export PATH="$PATH:/opt/homebrew/bin"
if which swiftgen > /dev/null; then
swiftgen config run
else
echo "warning: SwiftGen not installed, download it from https://github.com/SwiftGen/SwiftGen"
fi
