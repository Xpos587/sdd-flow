#!/bin/bash

EVENT_TYPE="${CLAUDE_EVENT_TYPE:-Notification}"
TOOL_NAME="${CLAUDE_TOOL_NAME:-unknown}"
NOTIFICATION_TEXT="${CLAUDE_NOTIFICATION:-Task completed!}"

case "$EVENT_TYPE" in
"Stop")
	ICON="dialog-information"
	TITLE="Claude - Completed"
	SOUND="complete.oga"
	;;
"Notification")
	ICON="dialog-warning"
	TITLE="Claude - Attention"
	SOUND="dialog-warning.oga"
	;;
"PostToolUse")
	ICON="dialog-ok"
	TITLE="Claude - Tool Done"
	SOUND="message-new-instant.oga"
	;;
*)
	ICON="dialog-information"
	TITLE="Claude"
	SOUND="bell.oga"
	;;
esac

MESSAGE="$NOTIFICATION_TEXT"
[ -n "$TOOL_NAME" ] && [ "$TOOL_NAME" != "unknown" ] && MESSAGE="Tool: $TOOL_NAME\n$MESSAGE"

notify-send -e -h string:x-canonical-private-synchronous:claude-notification \
	-h "int:value:100" -t 3000 -i "$ICON" "$TITLE" "$MESSAGE"

paplay "/usr/share/sounds/freedesktop/stereo/$SOUND" 2>/dev/null &
