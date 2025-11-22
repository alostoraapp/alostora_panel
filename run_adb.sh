#!/usr/bin/expect -f

set timeout -1

spawn sh -i -c {
    .fvm/flutter_sdk/bin/flutter run -d web-server --web-port 4000 --web-hostname 0.0.0.0
}

set run_id $spawn_id

expect "For a more detailed help message, press \"h\". To quit, press \"q\"."
spawn sh -c {
    adb reverse tcp:4000 tcp:4000
    adb shell am start -a android.intent.action.VIEW -d http://localhost:4000
}

interact -i $run_id