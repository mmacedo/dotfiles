# To make history-substring-search work
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes

# setup ~/bin path
export PATH="/home/mmacedo/bin:$PATH"

# setup elixir path
export PATH="/home/mmacedo/elixir/bin:$PATH"

# setup SBT path
export PATH="/home/mmacedo/sbt/bin:$PATH"

# setup Scala path
export PATH="/home/mmacedo/scala/bin:$PATH"

# setup ADT paths
export ANDROID_SDK_HOME="/home/mmacedo/adt/sdk"
export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"

# setup Heroku Toolbelt path
export PATH="/usr/local/heroku/bin:$PATH"
