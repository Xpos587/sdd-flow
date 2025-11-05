# Стандарты разработки мультибанковского агрегатора

## 1. Структура проекта

### Организация директорий

```
vtb-multibank-api/
├── src/
│   ├── backend/                 # FastAPI backend
│   │   ├── api/                # API слой
│   │   │   └── v1/             # API v1 с роутерами
│   │   ├── core/               # Ядро приложения (конфиг, логирование)
│   │   ├── domains/            # Доменно-ориентированная структура
│   │   │   ├── accounts/       # Домен счетов
│   │   │   ├── payments/       # Домен платежей
│   │   │   ├── auth/           # Домен аутентификации
│   │   │   └── banks/          # Домен банковских интеграций
│   │   └── services/           # Сервисные слои
│   └── frontend/               # React + Bun frontend
│       ├── components/         # UI компоненты
│       │   └── ui/            # shadcn/ui компоненты
│       ├── lib/               # Утилиты и библиотеки
│       └── styles/            # Стили (TailwindCSS)
├── docs/                      # Документация
├── deploy/                    # Деплой конфигурации
└── tools/                     # Инструменты разработки
```

### Именование файлов

- **Python**: `snake_case.py` для модулей, `PascalCase.py` для классов
- **TypeScript**: `PascalCase.tsx` для компонентов, `camelCase.ts` для утилит
- **Документация**: `snake_case.md` для markdown файлов
- **Конфигурации**: `kebab-case.yaml` или `UPPER_CASE.env`

## 2. Паттерны проектирования

### Backend паттерны

#### Dependency Injection
Использование встроенной DI FastAPI для управления зависимостями:

```python
from typing import Annotated
from fastapi import Depends

async def get_db_session():
    async with SessionLocal() as session:
        try:
            yield session
        finally:
            await session.close()

@router.get("/accounts")
async def get_accounts(
    session: Annotated[AsyncSession, Depends(get_db_session)],
    current_user: Annotated[User, Depends(get_current_user)]
):
    return await account_service.get_user_accounts(session, current_user.id)
```

#### Repository Pattern
Абстрагирование работы с данными:

```python
class AccountRepository:
    async def get_by_user_id(self, session: AsyncSession, user_id: str) -> List[Account]:
        result = await session.execute(
            select(Account).where(Account.user_id == user_id)
        )
        return result.scalars().all()
```

#### Service Layer Pattern
Инкапсуляция бизнес-логики:

```python
class AccountService:
    def __init__(self, account_repo: AccountRepository, bank_gateway: BankGateway):
        self.account_repo = account_repo
        self.bank_gateway = bank_gateway

    async def sync_accounts(self, user_id: str, bank_code: str) -> List[Account]:
        # Бизнес-логика синхронизации счетов
        pass
```

#### Adapter Pattern для банковских API
Унификация интерфейсов разных банков:

```python
from abc import ABC, abstractmethod

class BankAdapter(ABC):
    @abstractmethod
    async def get_accounts(self, access_token: str) -> List[BankAccount]:
        pass

    @abstractmethod
    async def initiate_payment(self, payment: PaymentRequest) -> PaymentResponse:
        pass

class ABankAdapter(BankAdapter):
    async def get_accounts(self, access_token: str) -> List[BankAccount]:
        # Реализация для ABank API
        pass
```

### Frontend паттерны

#### Component Composition
Использование composition вместо inheritance:

```typescript
interface ButtonProps {
  variant: "default" | "destructive" | "outline" | "secondary"
  size: "default" | "sm" | "lg" | "icon"
  children: React.ReactNode
}

export function Button({ variant, size, children, ...props }: ButtonProps) {
  return (
    <button
      className={cn(buttonVariants({ variant, size }))}
      {...props}
    >
      {children}
    </button>
  )
}
```

#### Custom Hooks
Инкапсуляция логики компонентов:

```typescript
export function useAccounts() {
  const [accounts, setAccounts] = useState<Account[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const fetchAccounts = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const response = await api.get('/accounts')
      setAccounts(response.data)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }, [])

  return { accounts, loading, error, fetchAccounts }
}
```

## 3. Работа с Git

### Ветвление

Используем **GitHub Flow**:

1. **`main`** - продакшен ветка, защищена
2. **`develop`** - ветка разработки
3. **`feature/*`** - ветки для новых функций
4. **`hotfix/*`** - срочные исправления
5. **`release/*`** - подготовка релиза

### Правила именования веток

```
feature/accounts-aggregation
feature/payment-confirmation
hotfix/cors-configuration
release/v1.0.0
fix/oauth-token-refresh
docs/api-documentation
```

### Conventional Commits

Формат коммитов:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Типы коммитов

- **`feat`**: новая функциональность
- **`fix`**: исправление бага
- **`docs`**: документация
- **`style`**: форматирование кода (не меняющее логику)
- **`refactor`**: рефакторинг кода
- **`perf`**: оптимизация производительности
- **`test`**: тесты
- **`chore`**: рутинные задачи (обновление зависимостей, etc.)
- **`ci`**: изменения в CI/CD

#### Примеры

```
feat(auth): implement OAuth 2.0 flow with PKCE

Add support for OAuth 2.0 authorization code flow with PKCE
for secure authentication with banking APIs.

Closes #123

fix(api): handle token expiration gracefully

Implement automatic token refresh when access token expires
during API calls to prevent user session interruption.

docs(api): update OpenAPI documentation

Add detailed descriptions for payment endpoints and include
request/response examples.

refactor(bank-gateway): extract common HTTP client logic

Create shared HTTP client base class to reduce code duplication
across different bank adapter implementations.
```

### Pull Request процесс

#### Требования к PR

1. **Заголовок**: должен соответствовать Conventional Commits
2. **Описание**: включать:
   - Краткое описание изменений
   - Контекст и причины изменений
   - Ссылки на связанные issues
   - Инструкции по тестированию

3. **Ревьюверы**: минимум 1 approval от senior разработчика
4. **CI checks**: все проверки должны проходить
5. **Тесты**: покрытие новых функций тестами

#### Template для PR

```markdown
## Описание
Краткое описание изменений и их цель.

## Изменения
- [ ] Изменение 1
- [ ] Изменение 2
- [ ] Изменение 3

## Тестирование
Инструкция по проверке изменений:
1. Запустить `just dev-backend`
2. Перейти на `http://localhost:8000/docs`
3. Проверить эндпоинты...

## Related Issues
Closes #123, Fixes #456

## Checklist
- [ ] Код соответствует style guide
- [ ] Добавлены/обновлены тесты
- [ ] Документация обновлена
- [ ] CI checks проходят
```

## 4. Работа с OpenBanking API

### Стандарты интеграции

#### Конфигурация банковских клиентов

```python
# src/backend/core/bank_config.py
from pydantic import BaseModel
from typing import Dict, Any

class BankConfig(BaseModel):
    code: str
    name: str
    oauth_url: str
    api_base_url: str
    client_id: str
    client_secret: str
    scopes: List[str]
    supports_payments: bool
    test_mode: bool = True

BANK_CONFIGS: Dict[str, BankConfig] = {
    "abank": BankConfig(
        code="abank",
        name="А-Банк",
        oauth_url="https://api.abank.ru/oauth",
        api_base_url="https://api.abank.ru/v1",
        client_id="${ABANK_CLIENT_ID}",
        client_secret="${ABANK_CLIENT_SECRET}",
        scopes=["accounts", "balances", "transactions", "payments"],
        supports_payments=True
    ),
    # ... другие банки
}
```

#### Обработка ошибок API

```python
from enum import Enum
from typing import Optional

class BankErrorType(str, Enum):
    INVALID_TOKEN = "INVALID_TOKEN"
    INSUFFICIENT_PERMISSIONS = "INSUFFICIENT_PERMISSIONS"
    RATE_LIMITED = "RATE_LIMITED"
    BANK_UNAVAILABLE = "BANK_UNAVAILABLE"
    INVALID_REQUEST = "INVALID_REQUEST"

class BankAPIError(Exception):
    def __init__(
        self,
        bank_code: str,
        error_type: BankErrorType,
        message: str,
        details: Optional[Dict[str, Any]] = None
    ):
        self.bank_code = bank_code
        self.error_type = error_type
        self.message = message
        self.details = details or {}
        super().__init__(f"[{bank_code}] {error_type.value}: {message}")

async def handle_bank_api_response(response: httpx.Response, bank_code: str):
    if response.status_code == 401:
        raise BankAPIError(bank_code, BankErrorType.INVALID_TOKEN, "Access token expired")
    elif response.status_code == 403:
        raise BankAPIError(bank_code, BankErrorType.INSUFFICIENT_PERMISSIONS, "Insufficient permissions")
    elif response.status_code == 429:
        raise BankAPIError(bank_code, BankErrorType.RATE_LIMITED, "Rate limit exceeded")
    elif response.status_code >= 500:
        raise BankAPIError(bank_code, BankErrorType.BANK_UNAVAILABLE, "Bank service unavailable")
```

#### Управление токенами

```python
from cryptography.fernet import Fernet
from src.backend.core.config import settings

class TokenManager:
    def __init__(self):
        self.cipher = Fernet(settings.token_encryption_key.encode())

    def encrypt_token(self, token: str) -> str:
        return self.cipher.encrypt(token.encode()).decode()

    def decrypt_token(self, encrypted_token: str) -> str:
        return self.cipher.decrypt(encrypted_token.encode()).decode()

    async def refresh_access_token(self, bank_code: str, refresh_token: str) -> str:
        # Логика обновления access token
        pass
```

### Graceful degradation

```python
import asyncio
from typing import List, Dict, Any

async def get_aggregated_balances(user_id: str) -> Dict[str, Any]:
    bank_codes = await get_user_connected_banks(user_id)

    tasks = []
    for bank_code in bank_codes:
        task = get_bank_balances_safe(bank_code, user_id)
        tasks.append(task)

    results = await asyncio.gather(*tasks, return_exceptions=True)

    successful_results = {}
    failed_banks = []

    for bank_code, result in zip(bank_codes, results):
        if isinstance(result, Exception):
            failed_banks.append({
                "bank_code": bank_code,
                "error": str(result),
                "timestamp": datetime.utcnow()
            })
        else:
            successful_results[bank_code] = result

    return {
        "balances": successful_results,
        "failed_banks": failed_banks,
        "total_banks": len(bank_codes),
        "successful_banks": len(successful_results)
    }

async def get_bank_balances_safe(bank_code: str, user_id: str) -> Dict[str, Any]:
    try:
        adapter = get_bank_adapter(bank_code)
        return await adapter.get_balances(user_id)
    except Exception as e:
        logger.warning(f"Failed to get balances from {bank_code}: {e}")
        raise
```

## 5. Тестирование

### Тестовая пирамида

1. **Unit тесты (70%)** - тестирование отдельных функций и классов
2. **Integration тесты (20%)** - тестирование взаимодействия компонентов
3. **E2E тесты (10%)** - тестирование пользовательских сценариев

### Backend тестирование

#### Unit тесты

```python
# tests/test_account_service.py
import pytest
from unittest.mock import AsyncMock, Mock

from src.backend.services.account_service import AccountService
from src.backend.repositories.account_repository import AccountRepository

@pytest.fixture
def mock_account_repo():
    return AsyncMock(spec=AccountRepository)

@pytest.fixture
def mock_bank_gateway():
    return AsyncMock()

@pytest.fixture
def account_service(mock_account_repo, mock_bank_gateway):
    return AccountService(mock_account_repo, mock_bank_gateway)

@pytest.mark.asyncio
async def test_sync_accounts_success(account_service, mock_account_repo, mock_bank_gateway):
    # Arrange
    user_id = "user123"
    bank_code = "abank"
    expected_accounts = [
        {"id": "acc1", "balance": 1000, "currency": "RUB"},
        {"id": "acc2", "balance": 5000, "currency": "RUB"}
    ]

    mock_bank_gateway.get_accounts.return_value = expected_accounts
    mock_account_repo.upsert_accounts.return_value = None

    # Act
    result = await account_service.sync_accounts(user_id, bank_code)

    # Assert
    assert len(result) == 2
    mock_bank_gateway.get_accounts.assert_called_once()
    mock_account_repo.upsert_accounts.assert_called_once()
```

#### Integration тесты

```python
# tests/test_bank_api_integration.py
import pytest
from httpx import AsyncClient

from src.backend.app import app

@pytest.mark.asyncio
async def test_accounts_endpoint_integration():
    async with AsyncClient(app=app, base_url="http://test") as client:
        # Требуется мокирование OAuth токена
        response = await client.get(
            "/api/v1/accounts",
            headers={"Authorization": "Bearer mock_token"}
        )
        assert response.status_code == 200
        assert "accounts" in response.json()
```

### Frontend тестирование

#### Component тесты с React Testing Library

```typescript
// tests/components/AccountCard.test.tsx
import { render, screen } from '@testing-library/react'
import { AccountCard } from '@/components/AccountCard'

const mockAccount = {
  id: 'acc1',
  name: 'Основной счет',
  balance: 10000,
  currency: 'RUB',
  bank: 'abank'
}

describe('AccountCard', () => {
  it('displays account information correctly', () => {
    render(<AccountCard account={mockAccount} />)

    expect(screen.getByText('Основной счет')).toBeInTheDocument()
    expect(screen.getByText('10 000 ₽')).toBeInTheDocument()
    expect(screen.getByText('А-Банк')).toBeInTheDocument()
  })

  it('handles balance formatting', () => {
    const largeBalanceAccount = { ...mockAccount, balance: 1234567.89 }
    render(<AccountCard account={largeBalanceAccount} />)

    expect(screen.getByText('1 234 567.89 ₽')).toBeInTheDocument()
  })
})
```

#### Hook тесты

```typescript
// tests/hooks/useAccounts.test.tsx
import { renderHook, waitFor } from '@testing-library/react'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { useAccounts } from '@/hooks/useAccounts'

const createWrapper = () => {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
  return ({ children }: { children: React.ReactNode }) => (
    <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
  )
}

describe('useAccounts', () => {
  it('fetches accounts successfully', async () => {
    const { result } = renderHook(() => useAccounts(), {
      wrapper: createWrapper(),
    })

    expect(result.current.loading).toBe(true)

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
      expect(result.current.accounts).toHaveLength(2)
    })
  })
})
```

### Тестирование API банков

```python
# tests/test_bank_adapters.py
import pytest
from unittest.mock import patch

from src.backend.adapters.abank_adapter import ABankAdapter

class TestABankAdapter:
    @pytest.fixture
    def adapter(self):
        return ABankAdapter(
            client_id="test_client",
            client_secret="test_secret",
            base_url="https://test.api.abank.ru"
        )

    @patch('httpx.AsyncClient.post')
    async def test_get_accounts_success(self, mock_post, adapter):
        # Arrange
        mock_post.return_value.json.return_value = {
            "data": {
                "accounts": [
                    {"id": "acc1", "name": "Счет 1", "balance": 1000}
                ]
            }
        }
        mock_post.return_value.status_code = 200

        # Act
        result = await adapter.get_accounts("mock_token")

        # Assert
        assert len(result) == 1
        assert result[0]["id"] == "acc1"
        mock_post.assert_called_once()
```

## 6. UX/UI принципы

### Дизайн система

#### Цветовая схема
```css
/* Основные цвета */
:root {
  --primary: 220 90% 56%;
  --primary-foreground: 210 40% 98%;

  /* Банковские цвета */
  --success: 142 76% 36%;    /* Зеленый для успешных операций */
  --warning: 38 92% 50%;     /* Желтый для предупреждений */
  --error: 0 84% 60%;        /* Красный для ошибок */

  /* Нейтральные цвета */
  --muted: 210 40% 96%;
  --border: 214 32% 91%;
}
```

#### Типографика
```css
/* Шрифты и размеры */
.font-heading {
  font-family: 'Inter', sans-serif;
  font-weight: 600;
}

.font-body {
  font-family: 'Inter', sans-serif;
  font-weight: 400;
}

/* Размеры для денежных сумм */
.text-amount-large {
  @apply text-2xl font-mono font-semibold;
}

.text-amount-small {
  @apply text-sm font-mono;
}
```

### Пользовательский опыт

#### Принципы
1. **Ясность** - информация понятна без лишнего шума
2. **Доступность** - соответствие WCAG 2.1 AA
3. **Отзывчивость** - немедленная реакция на действия
4. **Безопасность** - пользователи чувствуют себя защищенными

#### Обработка состояний загрузки
```typescript
// Пример компонента с состояниями
function AccountBalance({ account }: { account: Account }) {
  const { balance, loading, error, refetch } = useAccountBalance(account.id)

  if (loading) {
    return <Skeleton className="h-8 w-32" />
  }

  if (error) {
    return (
      <div className="flex items-center gap-2 text-destructive">
        <AlertCircle className="h-4 w-4" />
        <span className="text-sm">Ошибка загрузки</span>
        <Button variant="ghost" size="sm" onClick={refetch}>
          Повторить
        </Button>
      </div>
    )
  }

  return (
    <div className="text-2xl font-mono">
      {formatCurrency(balance, account.currency)}
    </div>
  )
}
```

#### Обработка ошибок
```typescript
// Глобальная обработка ошибок
export function ErrorBoundary({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen bg-background">
      <nav>
        {/* Навигация */}
      </nav>

      <main>
        <ErrorBoundaryFallback>
          {children}
        </ErrorBoundaryFallback>
      </main>
    </div>
  )
}

function ErrorBoundaryFallback({ children }: { children: React.ReactNode }) {
  return (
    <ErrorBoundary
      fallback={
        <div className="container mx-auto p-8 text-center">
          <div className="max-w-md mx-auto">
            <AlertTriangle className="h-12 w-12 text-destructive mx-auto mb-4" />
            <h1 className="text-2xl font-bold mb-2">Что-то пошло не так</h1>
            <p className="text-muted-foreground mb-4">
              Произошла непредвиденная ошибка. Попробуйте обновить страницу.
            </p>
            <Button onClick={() => window.location.reload()}>
              Обновить страницу
            </Button>
          </div>
        </div>
      }
    >
      {children}
    </ErrorBoundary>
  )
}
```

### Mobile-first дизайн

```typescript
// Адаптивный компонент карточки счета
export function AccountCard({ account }: { account: Account }) {
  return (
    <Card className="w-full">
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between gap-4">
          <div className="min-w-0 flex-1">
            <CardTitle className="text-lg truncate">
              {account.name}
            </CardTitle>
            <CardDescription className="text-sm">
              {account.bank}
            </CardDescription>
          </div>

          {/* Бейдж статуса */}
          <Badge variant={account.isActive ? 'default' : 'secondary'}>
            {account.isActive ? 'Активен' : 'Неактивен'}
          </Badge>
        </div>
      </CardHeader>

      <CardContent>
        <div className="space-y-2">
          {/* Баланс */}
          <div className="text-2xl font-mono font-semibold">
            {formatCurrency(account.balance, account.currency)}
          </div>

          {/* Действия */}
          <div className="flex gap-2 pt-2">
            <Button size="sm" className="flex-1">
              Детали
            </Button>
            <Button size="sm" variant="outline" className="flex-1">
              Перевод
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
```

## 7. Инструменты и автоматизация

### Форматирование и линтинг

#### Python (Backend)
```bash
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/psf/black
    rev: 23.0.0
    hooks:
      - id: black

  - repo: https://github.com/PyCQA/bandit
    rev: 1.7.5
    hooks:
      - id: bandit
        args: [-c, pyproject.toml]
        additional_dependencies: ["bandit[toml]"]
```

#### TypeScript (Frontend)
```json
// package.json scripts
{
  "scripts": {
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "lint:fix": "eslint . --ext ts,tsx --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,css,md}\"",
    "type-check": "tsc --noEmit"
  }
}
```

### Quality Gates

#### Just команды
```makefile
# Justfile
# Форматирование всего кода
format: format-backend format-frontend

# Проверка качества кода
lint: lint-backend lint-frontend security-backend

# Полная проверка перед коммитом
pre-commit: format lint test

# Запуск тестов
test: test-backend test-frontend

# Запуск всех проверок (CI)
check: lint test security-scan
```

#### GitHub Actions
```yaml
# .github/workflows/quality-gate.yml
name: Quality Gate

on: [push, pull_request]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: |
          pip install -r requirements-dev.txt
          npm ci

      - name: Run quality checks
        run: just check

      - name: Run tests
        run: just test

      - name: Security scan
        run: just security-scan
```

Этот документ устанавливает единые стандарты разработки для команды, обеспечивая качество кода, безопасность и хороший пользовательский опыт в соответствии с требованиями хакатона.