# Check if file "GoogleService-Info.plist" exists
if [ -e "${PROJECT_DIR}/GoogleService-Info.plist" ]; then
    # If the file exists, run Crashlytics
    "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
fi
