const Theme g_themeDockLike = {{
    ThemeTargetStyles{L"Taskbar.TaskbarFrame", {
        L"Width=Auto",
        L"HorizontalAlignment=Center",
        L"Margin=50,0,50,0"}},  // Reduced margin to allow more space
    ThemeTargetStyles{L"Taskbar.TaskbarFrame > Grid#RootGrid", {
        L"Background:=<WindhawkBlur BlurAmount=\"18\" TintColor=\"#25323232\"/>",
        L"Padding=6,0,6,0",
        L"CornerRadius=8,8,8,8",
        L"BorderBrush:=<SolidColorBrush Color=\"{ThemeResource SurfaceStrokeColorDefault}\" />",
        L"Margin=0,0,0,6"}},
    ThemeTargetStyles{L"Taskbar.TaskbarFrame > Grid#RootGrid > Taskbar.TaskbarBackground > Grid > Rectangle#BackgroundFill", {
        L"Visibility=Collapsed"}},
    ThemeTargetStyles{L"Rectangle#BackgroundStroke", {
        L"Visibility=Collapsed"}},
    ThemeTargetStyles{L"Taskbar.AugmentedEntryPointButton#AugmentedEntryPointButton > Taskbar.TaskListButtonPanel#ExperienceToggleButtonRootPanel", {
        L"Margin=0"}},
    ThemeTargetStyles{L"Grid#SystemTrayFrameGrid", {
        L"Background:=<WindhawkBlur BlurAmount=\"18\" TintColor=\"#25323232\"/>",
        L"Margin=-4,-8,-4,-2",
        L"CornerRadius=10",
        L"BorderThickness=8,8,8,8",  // Reduced border thickness
        L"BackgroundSizing=InnerBorderEdge"}},
    ThemeTargetStyles{L"SystemTray.ChevronIconView", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.NotifyIconView#NotifyItemIcon", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.OmniButton", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.CopilotIcon", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.OmniButton#NotificationCenterButton > Grid > ContentPresenter > ItemsPresenter > StackPanel > ContentPresenter > systemtray:IconView#SystemTrayIcon > Grid", {
        L"Padding=4,0,4,0"}},
    ThemeTargetStyles{L"SystemTray.IconView#SystemTrayIcon > Grid#ContainerGrid > ContentPresenter#ContentPresenter > Grid#ContentGrid > SystemTray.TextIconContent > Grid#ContainerGrid", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.StackListView#IconStack > ItemsPresenter > StackPanel > ContentPresenter > SystemTray.IconView#SystemTrayIcon", {
        L"Padding=0"}},
    ThemeTargetStyles{L"SystemTray.Stack#ShowDesktopStack", {
        L"Margin=0,-4,-12,-4"}},
    ThemeTargetStyles{L"Taskbar.Gripper#GripperControl", {
        L"Width=Auto",
        L"MinWidth=24"}},
}};
