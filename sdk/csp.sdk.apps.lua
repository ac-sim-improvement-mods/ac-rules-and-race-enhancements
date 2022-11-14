---@meta
---@diagnostic disable: lowercase-global

--[[ enums.lua ]]

---@alias os.DialogFlags
---| `os.DialogFlags.None` @Value: 0.
---| `os.DialogFlags.OverwritePrompt` @When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
---| `os.DialogFlags.StrictFileTypes` @In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
---| `os.DialogFlags.NoChangeDir` @Don't change the current working directory.
---| `os.DialogFlags.PickFolders` @Present an Open dialog that offers a choice of folders rather than files.
---| `os.DialogFlags.ForceFileSystem` @Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
---| `os.DialogFlags.AllNonStorageItems` @Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
---| `os.DialogFlags.NoValidate` @Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
---| `os.DialogFlags.AllowMultiselect` @Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
---| `os.DialogFlags.PathMustExist` @The item returned must be in an existing folder. This is a default value.
---| `os.DialogFlags.FileMustExist` @The item returned must exist. This is a default value for the Open dialog.
---| `os.DialogFlags.CreatePrompt` @Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
---| `os.DialogFlags.ShareAware` @In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
---| `os.DialogFlags.NoReadonlyReturn` @Do not return read-only items. This is a default value for the Save dialog.
---| `os.DialogFlags.NoTestFileCreate` @Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
---| `os.DialogFlags.HideMRUPlaces` @Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
---| `os.DialogFlags.HidePinnedPlaces` @Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
---| `os.DialogFlags.NoDereferenceLinks` @Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
---| `os.DialogFlags.OkButtonNeedsInteraction` @The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
---| `os.DialogFlags.DontAddToRecent` @Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
---| `os.DialogFlags.ForceShowHidden` @Include hidden and system items.
---| `os.DialogFlags.DefaultNoMiniMode` @Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
---| `os.DialogFlags.ForcePreviewPaneOn` @Indicates to the Open dialog box that the preview pane should always be displayed.
---| `os.DialogFlags.SupportStreamableItems` @Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
os.DialogFlags = {
  None = 0, ---Value: 0.
  OverwritePrompt = 2, ---When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
  StrictFileTypes = 4, ---In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
  NoChangeDir = 8, ---Don't change the current working directory.
  PickFolders = 32, ---Present an Open dialog that offers a choice of folders rather than files.
  ForceFileSystem = 64, ---Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
  AllNonStorageItems = 128, ---Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
  NoValidate = 256, ---Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
  AllowMultiselect = 512, ---Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
  PathMustExist = 2048, ---The item returned must be in an existing folder. This is a default value.
  FileMustExist = 4096, ---The item returned must exist. This is a default value for the Open dialog.
  CreatePrompt = 8192, ---Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
  ShareAware = 16384, ---In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
  NoReadonlyReturn = 32768, ---Do not return read-only items. This is a default value for the Save dialog.
  NoTestFileCreate = 65536, ---Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
  HideMRUPlaces = 131072, ---Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
  HidePinnedPlaces = 262144, ---Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
  NoDereferenceLinks = 1048576, ---Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
  OkButtonNeedsInteraction = 2097152, ---The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
  DontAddToRecent = 33554432, ---Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
  ForceShowHidden = 268435456, ---Include hidden and system items.
  DefaultNoMiniMode = 536870912, ---Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
  ForcePreviewPaneOn = 1073741824, ---Indicates to the Open dialog box that the preview pane should always be displayed.
  SupportStreamableItems = 2147483648, ---Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
}

---@alias ac.FogAlgorithm
---| `ac.FogAlgorithm.Original` @Value: 0.
---| `ac.FogAlgorithm.New` @Value: 1.
ac.FogAlgorithm = {
  Original = 0, ---Value: 0.
  New = 1, ---Value: 1.
}

---@alias ac.SurfaceType
---| `ac.SurfaceType.Grass` @Value: 0.
---| `ac.SurfaceType.Dirt` @Value: 1.
---| `ac.SurfaceType.Default` @Value: 255.
ac.SurfaceType = {
  Grass = 0, ---Value: 0.
  Dirt = 1, ---Value: 1.
  Default = 255, ---Value: 255.
}

---@alias ac.ShadowsState
---| `ac.ShadowsState.Off` @Value: 0.
---| `ac.ShadowsState.On` @Value: 1.
---| `ac.ShadowsState.EverythingShadowed` @Value: 2.
ac.ShadowsState = {
  Off = 0, ---Value: 0.
  On = 1, ---Value: 1.
  EverythingShadowed = 2, ---Value: 2.
}

---@alias ac.TextureState
---| `ac.TextureState.Empty` @Value: 0.
---| `ac.TextureState.Loading` @Value: 1.
---| `ac.TextureState.Failed` @Value: 2.
---| `ac.TextureState.Ready` @Value: 3.
ac.TextureState = {
  Empty = 0, ---Value: 0.
  Loading = 1, ---Value: 1.
  Failed = 2, ---Value: 2.
  Ready = 3, ---Value: 3.
}

---@alias ac.CameraMode
---| `ac.CameraMode.Cockpit` @First person view.
---| `ac.CameraMode.Car` @F6 camera.
---| `ac.CameraMode.Drivable` @Chase/bonnet/bumper/dash cameras.
---| `ac.CameraMode.Track` @Replay camera.
---| `ac.CameraMode.Helicopter` @Moving replay camera.
---| `ac.CameraMode.OnBoardFree` @F5 camera.
---| `ac.CameraMode.Free` @F7 camera.
---| `ac.CameraMode.Deprecated` @Value: 7.
---| `ac.CameraMode.ImageGeneratorCamera` @Value: 8.
---| `ac.CameraMode.Start` @Starting camera.
ac.CameraMode = {
  Cockpit = 0, ---First person view.
  Car = 1, ---F6 camera.
  Drivable = 2, ---Chase/bonnet/bumper/dash cameras.
  Track = 3, ---Replay camera.
  Helicopter = 4, ---Moving replay camera.
  OnBoardFree = 5, ---F5 camera.
  Free = 6, ---F7 camera.
  Deprecated = 7, ---Value: 7.
  ImageGeneratorCamera = 8, ---Value: 8.
  Start = 9, ---Starting camera.
}

---@alias ac.DrivableCamera
---| `ac.DrivableCamera.Chase` @Value: 0.
---| `ac.DrivableCamera.Chase2` @Value: 1.
---| `ac.DrivableCamera.Bonnet` @Value: 2.
---| `ac.DrivableCamera.Bumper` @Value: 3.
---| `ac.DrivableCamera.Dash` @Value: 4.
ac.DrivableCamera = {
  Chase = 0, ---Value: 0.
  Chase2 = 1, ---Value: 1.
  Bonnet = 2, ---Value: 2.
  Bumper = 3, ---Value: 3.
  Dash = 4, ---Value: 4.
}

---@alias ac.LightsDebugMode
---| `ac.LightsDebugMode.Off` @No special options.
---| `ac.LightsDebugMode.Outline` @Value: 0x1.
---| `ac.LightsDebugMode.BoundingBox` @Value: 0x2.
---| `ac.LightsDebugMode.BoundingSphere` @Value: 0x4.
---| `ac.LightsDebugMode.Text` @Value: 0x8.
ac.LightsDebugMode = {
  Off = 0x0, ---No special options.
  Outline = 0x1, ---Value: 0x1.
  BoundingBox = 0x2, ---Value: 0x2.
  BoundingSphere = 0x4, ---Value: 0x4.
  Text = 0x8, ---Value: 0x8.
}

---@alias ac.VAODebugMode
---| `ac.VAODebugMode.Active` @Value: 1.
---| `ac.VAODebugMode.Inactive` @Value: 3.
---| `ac.VAODebugMode.VAOOnly` @Value: 4.
---| `ac.VAODebugMode.ShowNormals` @Value: 5.
ac.VAODebugMode = {
  Active = 1, ---Value: 1.
  Inactive = 3, ---Value: 3.
  VAOOnly = 4, ---Value: 4.
  ShowNormals = 5, ---Value: 5.
}

---@alias ac.Wheel
---| `ac.Wheel.FrontLeft` @Value: 1.
---| `ac.Wheel.FrontRight` @Value: 2.
---| `ac.Wheel.RearLeft` @Value: 4.
---| `ac.Wheel.RearRight` @Value: 8.
---| `ac.Wheel.Front` @Value: 3.
---| `ac.Wheel.Rear` @Value: 12.
---| `ac.Wheel.Left` @Value: 5.
---| `ac.Wheel.Right` @Value: 10.
---| `ac.Wheel.All` @Value: 15.
ac.Wheel = {
  FrontLeft = 1, ---Value: 1.
  FrontRight = 2, ---Value: 2.
  RearLeft = 4, ---Value: 4.
  RearRight = 8, ---Value: 8.
  Front = 3, ---Value: 3.
  Rear = 12, ---Value: 12.
  Left = 5, ---Value: 5.
  Right = 10, ---Value: 10.
  All = 15, ---Value: 15.
}

---@alias ac.MirrorPieceRole
---| `ac.MirrorPieceRole.None` @Value: 0.
---| `ac.MirrorPieceRole.Top` @Value: 1.
---| `ac.MirrorPieceRole.Left` @Value: 2.
---| `ac.MirrorPieceRole.Right` @Value: 4.
ac.MirrorPieceRole = {
  None = 0, ---Value: 0.
  Top = 1, ---Value: 1.
  Left = 2, ---Value: 2.
  Right = 4, ---Value: 4.
}

---@alias ac.MirrorPieceFlip
---| `ac.MirrorPieceFlip.None` @Value: 0.
---| `ac.MirrorPieceFlip.Horizontal` @Value: 1.
---| `ac.MirrorPieceFlip.Vertical` @Value: 2.
---| `ac.MirrorPieceFlip.Both` @Value: 3.
ac.MirrorPieceFlip = {
  None = 0, ---Value: 0.
  Horizontal = 1, ---Value: 1.
  Vertical = 2, ---Value: 2.
  Both = 3, ---Value: 3.
}

---@alias ac.MirrorMonitorType
---| `ac.MirrorMonitorType.TN` @Oldschool displays with a lot of color distortion.
---| `ac.MirrorMonitorType.VA` @Medium tier, less color distortion.
---| `ac.MirrorMonitorType.IPS` @Almost no color distortion.
ac.MirrorMonitorType = {
  TN = 0, ---Oldschool displays with a lot of color distortion.
  VA = 2, ---Medium tier, less color distortion.
  IPS = 1, ---Almost no color distortion.
}

---@alias ac.WeatherType
---| `ac.WeatherType.LightThunderstorm` @Value: 0.
---| `ac.WeatherType.Thunderstorm` @Value: 1.
---| `ac.WeatherType.HeavyThunderstorm` @Value: 2.
---| `ac.WeatherType.LightDrizzle` @Value: 3.
---| `ac.WeatherType.Drizzle` @Value: 4.
---| `ac.WeatherType.HeavyDrizzle` @Value: 5.
---| `ac.WeatherType.LightRain` @Value: 6.
---| `ac.WeatherType.Rain` @Value: 7.
---| `ac.WeatherType.HeavyRain` @Value: 8.
---| `ac.WeatherType.LightSnow` @Value: 9.
---| `ac.WeatherType.Snow` @Value: 10.
---| `ac.WeatherType.HeavySnow` @Value: 11.
---| `ac.WeatherType.LightSleet` @Value: 12.
---| `ac.WeatherType.Sleet` @Value: 13.
---| `ac.WeatherType.HeavySleet` @Value: 14.
---| `ac.WeatherType.Clear` @Value: 15.
---| `ac.WeatherType.FewClouds` @Value: 16.
---| `ac.WeatherType.ScatteredClouds` @Value: 17.
---| `ac.WeatherType.BrokenClouds` @Value: 18.
---| `ac.WeatherType.OvercastClouds` @Value: 19.
---| `ac.WeatherType.Fog` @Value: 20.
---| `ac.WeatherType.Mist` @Value: 21.
---| `ac.WeatherType.Smoke` @Value: 22.
---| `ac.WeatherType.Haze` @Value: 23.
---| `ac.WeatherType.Sand` @Value: 24.
---| `ac.WeatherType.Dust` @Value: 25.
---| `ac.WeatherType.Squalls` @Value: 26.
---| `ac.WeatherType.Tornado` @Value: 27.
---| `ac.WeatherType.Hurricane` @Value: 28.
---| `ac.WeatherType.Cold` @Value: 29.
---| `ac.WeatherType.Hot` @Value: 30.
---| `ac.WeatherType.Windy` @Value: 31.
---| `ac.WeatherType.Hail` @Value: 32.
ac.WeatherType = {
  LightThunderstorm = 0, ---Value: 0.
  Thunderstorm = 1, ---Value: 1.
  HeavyThunderstorm = 2, ---Value: 2.
  LightDrizzle = 3, ---Value: 3.
  Drizzle = 4, ---Value: 4.
  HeavyDrizzle = 5, ---Value: 5.
  LightRain = 6, ---Value: 6.
  Rain = 7, ---Value: 7.
  HeavyRain = 8, ---Value: 8.
  LightSnow = 9, ---Value: 9.
  Snow = 10, ---Value: 10.
  HeavySnow = 11, ---Value: 11.
  LightSleet = 12, ---Value: 12.
  Sleet = 13, ---Value: 13.
  HeavySleet = 14, ---Value: 14.
  Clear = 15, ---Value: 15.
  FewClouds = 16, ---Value: 16.
  ScatteredClouds = 17, ---Value: 17.
  BrokenClouds = 18, ---Value: 18.
  OvercastClouds = 19, ---Value: 19.
  Fog = 20, ---Value: 20.
  Mist = 21, ---Value: 21.
  Smoke = 22, ---Value: 22.
  Haze = 23, ---Value: 23.
  Sand = 24, ---Value: 24.
  Dust = 25, ---Value: 25.
  Squalls = 26, ---Value: 26.
  Tornado = 27, ---Value: 27.
  Hurricane = 28, ---Value: 28.
  Cold = 29, ---Value: 29.
  Hot = 30, ---Value: 30.
  Windy = 31, ---Value: 31.
  Hail = 32, ---Value: 32.
}

---@alias ac.TonemapFunction
---| `ac.TonemapFunction.Linear` @Simple linear mapping.
---| `ac.TonemapFunction.LinearClamped` @Linear mapping (LDR clamp).
---| `ac.TonemapFunction.Sensitometric` @Simple simulation of response of film, CCD, etc., recommended.
---| `ac.TonemapFunction.Reinhard` @Reinhard.
---| `ac.TonemapFunction.ReinhardLum` @Saturation retention type Reinhard tone map function.
---| `ac.TonemapFunction.Log` @Tone map function for the logarithmic space.
---| `ac.TonemapFunction.LogLum` @Saturation retention type logarithmic space tone map function.
ac.TonemapFunction = {
  Linear = 0, ---Simple linear mapping.
  LinearClamped = 1, ---Linear mapping (LDR clamp).
  Sensitometric = 2, ---Simple simulation of response of film, CCD, etc., recommended.
  Reinhard = 3, ---Reinhard.
  ReinhardLum = 4, ---Saturation retention type Reinhard tone map function.
  Log = 5, ---Tone map function for the logarithmic space.
  LogLum = 6, ---Saturation retention type logarithmic space tone map function.
}

---@alias ac.FolderID
---| `ac.FolderID.AppData` @…/AppData.
---| `ac.FolderID.Documents` @…/Documents.
---| `ac.FolderID.Root` @…/SteamApps/common/assettocorsa.
---| `ac.FolderID.Cfg` @…/Documents/Assetto Corsa/cfg.
---| `ac.FolderID.Logs` @…/Documents/Assetto Corsa/logs.
---| `ac.FolderID.Screenshots` @…/Documents/Assetto Corsa/screens.
---| `ac.FolderID.Replays` @…/Documents/Assetto Corsa/replay.
---| `ac.FolderID.ReplaysTemp` @…/Documents/Assetto Corsa/replay/temp.
---| `ac.FolderID.UserSetups` @…/Documents/Assetto Corsa/setups.
---| `ac.FolderID.PPFilters` @…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
---| `ac.FolderID.ContentCars` @…/SteamApps/common/assettocorsa/content/cars.
---| `ac.FolderID.ContentDrivers` @…/SteamApps/common/assettocorsa/content/drivers.
---| `ac.FolderID.ContentTracks` @…/SteamApps/common/assettocorsa/content/tracks.
---| `ac.FolderID.ExtRoot` @…/SteamApps/common/assettocorsa/extension.
---| `ac.FolderID.ExtCfgSys` @…/SteamApps/common/assettocorsa/extension/config.
---| `ac.FolderID.ExtCfgUser` @…/Documents/Assetto Corsa/cfg/extension.
---| `ac.FolderID.ExtTextures` @…/SteamApps/common/assettocorsa/extension/textures.
---| `ac.FolderID.ACApps` @…/SteamApps/common/assettocorsa/apps.
---| `ac.FolderID.ACAppsPython` @…/SteamApps/common/assettocorsa/apps/python.
---| `ac.FolderID.ExtCfgState` @…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
---| `ac.FolderID.ContentFonts` @…/SteamApps/common/assettocorsa/content/fonts.
---| `ac.FolderID.RaceResults` @…/Documents/Assetto Corsa/out.
---| `ac.FolderID.AppDataLocal` @…/AppData/Local.
---| `ac.FolderID.ExtFonts` @…/SteamApps/common/assettocorsa/extension/fonts.
---| `ac.FolderID.ACDocuments` @…/Documents/Assetto Corsa.
---| `ac.FolderID.ExtLua` @…/SteamApps/common/assettocorsa/extension/lua.
---| `ac.FolderID.ExtCache` @…/SteamApps/common/assettocorsa/cache.
---| `ac.FolderID.AppDataTemp` @…/AppData/Local/Temp.
ac.FolderID = {
  AppData = 0, ---…/AppData.
  Documents = 1, ---…/Documents.
  Root = 4, ---…/SteamApps/common/assettocorsa.
  Cfg = 5, ---…/Documents/Assetto Corsa/cfg.
  Logs = 7, ---…/Documents/Assetto Corsa/logs.
  Screenshots = 8, ---…/Documents/Assetto Corsa/screens.
  Replays = 9, ---…/Documents/Assetto Corsa/replay.
  ReplaysTemp = 10, ---…/Documents/Assetto Corsa/replay/temp.
  UserSetups = 11, ---…/Documents/Assetto Corsa/setups.
  PPFilters = 12, ---…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
  ContentCars = 13, ---…/SteamApps/common/assettocorsa/content/cars.
  ContentDrivers = 14, ---…/SteamApps/common/assettocorsa/content/drivers.
  ContentTracks = 15, ---…/SteamApps/common/assettocorsa/content/tracks.
  ExtRoot = 16, ---…/SteamApps/common/assettocorsa/extension.
  ExtCfgSys = 17, ---…/SteamApps/common/assettocorsa/extension/config.
  ExtCfgUser = 18, ---…/Documents/Assetto Corsa/cfg/extension.
  ExtTextures = 21, ---…/SteamApps/common/assettocorsa/extension/textures.
  ACApps = 23, ---…/SteamApps/common/assettocorsa/apps.
  ACAppsPython = 24, ---…/SteamApps/common/assettocorsa/apps/python.
  ExtCfgState = 25, ---…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
  ContentFonts = 26, ---…/SteamApps/common/assettocorsa/content/fonts.
  RaceResults = 27, ---…/Documents/Assetto Corsa/out.
  AppDataLocal = 28, ---…/AppData/Local.
  ExtFonts = 29, ---…/SteamApps/common/assettocorsa/extension/fonts.
  ACDocuments = 31, ---…/Documents/Assetto Corsa.
  ExtLua = 32, ---…/SteamApps/common/assettocorsa/extension/lua.
  ExtCache = 33, ---…/SteamApps/common/assettocorsa/cache.
  AppDataTemp = 34, ---…/AppData/Local/Temp.
}

---@alias ac.HolidayType
---| `ac.HolidayType.None` @Value: 0.
---| `ac.HolidayType.NewYear` @Value: 1.
---| `ac.HolidayType.Christmas` @Value: 2.
---| `ac.HolidayType.VictoryDay` @Value: 3.
---| `ac.HolidayType.IndependenceDay` @Value: 4.
---| `ac.HolidayType.Halloween` @Value: 5.
---| `ac.HolidayType.JapanFestival` @Value: 6.
---| `ac.HolidayType.ChineseNewYear` @Value: 7.
---| `ac.HolidayType.EidAlAdha` @Value: 8.
---| `ac.HolidayType.GuyFawkesNight` @Value: 9.
---| `ac.HolidayType.StIstvanCelebration` @Value: 10.
---| `ac.HolidayType.CanadaDay` @Value: 11.
---| `ac.HolidayType.VictoriaDay` @Value: 12.
ac.HolidayType = {
  None = 0, ---Value: 0.
  NewYear = 1, ---Value: 1.
  Christmas = 2, ---Value: 2.
  VictoryDay = 3, ---Value: 3.
  IndependenceDay = 4, ---Value: 4.
  Halloween = 5, ---Value: 5.
  JapanFestival = 6, ---Value: 6.
  ChineseNewYear = 7, ---Value: 7.
  EidAlAdha = 8, ---Value: 8.
  GuyFawkesNight = 9, ---Value: 9.
  StIstvanCelebration = 10, ---Value: 10.
  CanadaDay = 11, ---Value: 11.
  VictoriaDay = 12, ---Value: 12.
}

---@alias ac.SkyRegion
---| `ac.SkyRegion.None` @Value: 0.
---| `ac.SkyRegion.Sun` @Value: 1.
---| `ac.SkyRegion.Opposite` @Value: 2.
---| `ac.SkyRegion.All` @Value: 3.
ac.SkyRegion = {
  None = 0, ---Value: 0.
  Sun = 1, ---Value: 1.
  Opposite = 2, ---Value: 2.
  All = 3, ---Value: 3.
}

---@alias ac.SkyFeature
---| `ac.SkyFeature.Sun` @Value: 0.
---| `ac.SkyFeature.Moon` @Value: 1.
---| `ac.SkyFeature.Mercury` @Value: 101.
---| `ac.SkyFeature.Venus` @Value: 102.
---| `ac.SkyFeature.Mars` @Value: 103.
---| `ac.SkyFeature.Jupiter` @Value: 104.
---| `ac.SkyFeature.Saturn` @Value: 105.
---| `ac.SkyFeature.ISS` @Value: 200.
ac.SkyFeature = {
  Sun = 0, ---Value: 0.
  Moon = 1, ---Value: 1.
  Mercury = 101, ---Value: 101.
  Venus = 102, ---Value: 102.
  Mars = 103, ---Value: 103.
  Jupiter = 104, ---Value: 104.
  Saturn = 105, ---Value: 105.
  ISS = 200, ---Value: 200.
}

---@alias ac.AudioChannel
---| `ac.AudioChannel.Main` @Value: 'main'.
---| `ac.AudioChannel.Rain` @Value: 'rain'.
ac.AudioChannel = {
  Main = 'main', ---Value: 'main'.
  Rain = 'rain', ---Value: 'rain'.
}

---@alias ac.SpawnSet
---| `ac.SpawnSet.Start` @Value: 'START'.
---| `ac.SpawnSet.Pits` @Value: 'PIT'.
---| `ac.SpawnSet.HotlapStart` @Value: 'HOTLAP_START'.
---| `ac.SpawnSet.TimeAttack` @Careful: most tracks might not have that spawn set.
ac.SpawnSet = {
  Start = 'START', ---Value: 'START'.
  Pits = 'PIT', ---Value: 'PIT'.
  HotlapStart = 'HOTLAP_START', ---Value: 'HOTLAP_START'.
  TimeAttack = 'TIME_ATTACK', ---Careful: most tracks might not have that spawn set.
}

---At the moment, most of those flag types are never shown, but more flags will be added later. Also, physics-altering scripts---(like, for example, server scripts) can override flag type and use any flag from this list (and apply their own rules and---penalties when needed)
---@alias ac.FlagType
---| `ac.FlagType.None` @No flag, works.
---| `ac.FlagType.Start` @Works in race, practice or hotlap modes.
---| `ac.FlagType.Caution` @Yellow flag, works.
---| `ac.FlagType.Slippery` @Does not work yet.
---| `ac.FlagType.PitLaneClosed` @Does not work yet.
---| `ac.FlagType.Stop` @Black flag, works.
---| `ac.FlagType.SlowVehicle` @Does not work yet.
---| `ac.FlagType.Ambulance` @Does not work yet.
---| `ac.FlagType.ReturnToPits` @Penalty flag, works.
---| `ac.FlagType.MechanicalFailure` @Does not work yet.
---| `ac.FlagType.Unsportsmanlike` @Does not work yet.
---| `ac.FlagType.StopCancel` @Does not work yet.
---| `ac.FlagType.FasterCar` @Blue flag, works.
---| `ac.FlagType.Finished` @Checkered flag, works.
---| `ac.FlagType.OneLapLeft` @White flag, works.
---| `ac.FlagType.SessionSuspended` @Does not work yet.
---| `ac.FlagType.Code60` @Does not work yet.
ac.FlagType = {
  None = 0, ---No flag, works.
  Start = 1, ---Works in race, practice or hotlap modes.
  Caution = 2, ---Yellow flag, works.
  Slippery = 3, ---Does not work yet.
  PitLaneClosed = 4, ---Does not work yet.
  Stop = 5, ---Black flag, works.
  SlowVehicle = 6, ---Does not work yet.
  Ambulance = 7, ---Does not work yet.
  ReturnToPits = 8, ---Penalty flag, works.
  MechanicalFailure = 9, ---Does not work yet.
  Unsportsmanlike = 10, ---Does not work yet.
  StopCancel = 11, ---Does not work yet.
  FasterCar = 12, ---Blue flag, works.
  Finished = 13, ---Checkered flag, works.
  OneLapLeft = 14, ---White flag, works.
  SessionSuspended = 15, ---Does not work yet.
  Code60 = 16, ---Does not work yet.
}

---@alias ac.InputMethod
---| `ac.InputMethod.Unknown` @Value: 0.
---| `ac.InputMethod.Wheel` @Value: 1.
---| `ac.InputMethod.Gamepad` @Value: 2.
---| `ac.InputMethod.Keyboard` @Value: 3.
---| `ac.InputMethod.AI` @Value: 4.
ac.InputMethod = {
  Unknown = 0, ---Value: 0.
  Wheel = 1, ---Value: 1.
  Gamepad = 2, ---Value: 2.
  Keyboard = 3, ---Value: 3.
  AI = 4, ---Value: 4.
}

---@alias ac.PenaltyType
---| `ac.PenaltyType.None` @No penalty.
---| `ac.PenaltyType.MandatoryPits` @Parameter: how many laps are left to do mandatory pits.
---| `ac.PenaltyType.TeleportToPits` @Parameter: how many seconds to wait in pits with locked controls.
---| `ac.PenaltyType.SlowDown` @Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
---| `ac.PenaltyType.BlackFlag` @Adds black flag, no parameter.
---| `ac.PenaltyType.ReleaseBlackFlag` @Removes previously set black flag, no parameter.
ac.PenaltyType = {
  None = 0, ---No penalty.
  MandatoryPits = 1, ---Parameter: how many laps are left to do mandatory pits.
  TeleportToPits = 2, ---Parameter: how many seconds to wait in pits with locked controls.
  SlowDown = 3, ---Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
  BlackFlag = 4, ---Adds black flag, no parameter.
  ReleaseBlackFlag = 5, ---Removes previously set black flag, no parameter.
}

---@alias ac.ImageFormat
---| `ac.ImageFormat.BMP` @Value: 0.
---| `ac.ImageFormat.JPG` @Value: 1.
---| `ac.ImageFormat.PNG` @Value: 2.
---| `ac.ImageFormat.DDS` @Value: 5.
---| `ac.ImageFormat.ZippedDDS` @DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
ac.ImageFormat = {
  BMP = 0, ---Value: 0.
  JPG = 1, ---Value: 1.
  PNG = 2, ---Value: 2.
  DDS = 5, ---Value: 5.
  ZippedDDS = 6, ---DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ac.KeyIndex
---| `ac.KeyIndex.LeftButton` @Value: 1.
---| `ac.KeyIndex.RightButton` @Value: 2.
---| `ac.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.Tab` @Value: 9.
---| `ac.KeyIndex.Return` @Value: 13.
---| `ac.KeyIndex.Shift` @Value: 16.
---| `ac.KeyIndex.Control` @Value: 17.
---| `ac.KeyIndex.Menu` @Aka Alt button.
---| `ac.KeyIndex.Escape` @Value: 27.
---| `ac.KeyIndex.Accept` @Value: 30.
---| `ac.KeyIndex.Space` @Value: 32.
---| `ac.KeyIndex.End` @Value: 35.
---| `ac.KeyIndex.Home` @Value: 36.
---| `ac.KeyIndex.Left` @Arrow ←.
---| `ac.KeyIndex.Up` @Arrow ↑.
---| `ac.KeyIndex.Right` @Arrow →.
---| `ac.KeyIndex.Down` @Arrow ↓.
---| `ac.KeyIndex.Insert` @Value: 45.
---| `ac.KeyIndex.Delete` @Value: 46.
---| `ac.KeyIndex.LeftWin` @Value: 91.
---| `ac.KeyIndex.RightWin` @Value: 92.
---| `ac.KeyIndex.NumPad0` @Value: 96.
---| `ac.KeyIndex.NumPad1` @Value: 97.
---| `ac.KeyIndex.NumPad2` @Value: 98.
---| `ac.KeyIndex.NumPad3` @Value: 99.
---| `ac.KeyIndex.NumPad4` @Value: 100.
---| `ac.KeyIndex.NumPad5` @Value: 101.
---| `ac.KeyIndex.NumPad6` @Value: 102.
---| `ac.KeyIndex.NumPad7` @Value: 103.
---| `ac.KeyIndex.NumPad8` @Value: 104.
---| `ac.KeyIndex.NumPad9` @Value: 105.
---| `ac.KeyIndex.Multiply` @Value: 106.
---| `ac.KeyIndex.Add` @Value: 107.
---| `ac.KeyIndex.Separator` @Value: 108.
---| `ac.KeyIndex.Subtract` @Value: 109.
---| `ac.KeyIndex.Decimal` @Value: 110.
---| `ac.KeyIndex.Divide` @Value: 111.
---| `ac.KeyIndex.F1` @Value: 112.
---| `ac.KeyIndex.F2` @Value: 113.
---| `ac.KeyIndex.F3` @Value: 114.
---| `ac.KeyIndex.F4` @Value: 115.
---| `ac.KeyIndex.F5` @Value: 116.
---| `ac.KeyIndex.F6` @Value: 117.
---| `ac.KeyIndex.F7` @Value: 118.
---| `ac.KeyIndex.F8` @Value: 119.
---| `ac.KeyIndex.F9` @Value: 120.
---| `ac.KeyIndex.F10` @Value: 121.
---| `ac.KeyIndex.F11` @Value: 122.
---| `ac.KeyIndex.F12` @Value: 123.
---| `ac.KeyIndex.NumLock` @Value: 144.
---| `ac.KeyIndex.Scroll` @Value: 145.
---| `ac.KeyIndex.OemNecEqual` @“.
---| `ac.KeyIndex.LeftShift` @Value: 160.
---| `ac.KeyIndex.RightShift` @Value: 161.
---| `ac.KeyIndex.LeftControl` @Value: 162.
---| `ac.KeyIndex.RightControl` @Value: 163.
---| `ac.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ac.KeyIndex.RightMenu` @Aka right Alt button.
---| `ac.KeyIndex.Oem1` @“;:” for US.
---| `ac.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ac.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ac.KeyIndex.D0` @Digit 0.
---| `ac.KeyIndex.D1` @Digit 1.
---| `ac.KeyIndex.D2` @Digit 2.
---| `ac.KeyIndex.D3` @Digit 3.
---| `ac.KeyIndex.D4` @Digit 4.
---| `ac.KeyIndex.D5` @Digit 5.
---| `ac.KeyIndex.D6` @Digit 6.
---| `ac.KeyIndex.D7` @Digit 7.
---| `ac.KeyIndex.D8` @Digit 8.
---| `ac.KeyIndex.D9` @Digit 9.
---| `ac.KeyIndex.A` @Letter A.
---| `ac.KeyIndex.B` @Letter B.
---| `ac.KeyIndex.C` @Letter C.
---| `ac.KeyIndex.D` @Letter D.
---| `ac.KeyIndex.E` @Letter E.
---| `ac.KeyIndex.F` @Letter F.
---| `ac.KeyIndex.G` @Letter G.
---| `ac.KeyIndex.H` @Letter H.
---| `ac.KeyIndex.I` @Letter I.
---| `ac.KeyIndex.J` @Letter J.
---| `ac.KeyIndex.K` @Letter K.
---| `ac.KeyIndex.L` @Letter L.
---| `ac.KeyIndex.M` @Letter M.
---| `ac.KeyIndex.N` @Letter N.
---| `ac.KeyIndex.O` @Letter O.
---| `ac.KeyIndex.P` @Letter P.
---| `ac.KeyIndex.Q` @Letter Q.
---| `ac.KeyIndex.R` @Letter R.
---| `ac.KeyIndex.S` @Letter S.
---| `ac.KeyIndex.T` @Letter T.
---| `ac.KeyIndex.U` @Letter U.
---| `ac.KeyIndex.V` @Letter V.
---| `ac.KeyIndex.W` @Letter W.
---| `ac.KeyIndex.X` @Letter X.
---| `ac.KeyIndex.Y` @Letter Y.
---| `ac.KeyIndex.Z` @Letter Z.
ac.KeyIndex = {
  LeftButton = 1, ---Value: 1.
  RightButton = 2, ---Value: 2.
  Cancel = 3, ---Value: 3.
  MiddleButton = 4, ---Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---Not contiguous with LeftButton and RightButton.
  Back = 8, ---Value: 8.
  Tab = 9, ---Value: 9.
  Clear = 12, ---Value: 12.
  Return = 13, ---Value: 13.
  Shift = 16, ---Value: 16.
  Control = 17, ---Value: 17.
  Menu = 18, ---Aka Alt button.
  Pause = 19, ---Value: 19.
  Capital = 20, ---Value: 20.
  Kana = 21, ---Value: 21.
  Hangeul = 21, ---Old name - should be here for compatibility.
  Hangul = 21, ---Value: 21.
  Junja = 23, ---Value: 23.
  Final = 24, ---Value: 24.
  Hanja = 25, ---Value: 25.
  Kanji = 25, ---Value: 25.
  Escape = 27, ---Value: 27.
  Convert = 28, ---Value: 28.
  NonConvert = 29, ---Value: 29.
  Accept = 30, ---Value: 30.
  ModeChange = 31, ---Value: 31.
  Space = 32, ---Value: 32.
  Prior = 33, ---Value: 33.
  Next = 34, ---Value: 34.
  End = 35, ---Value: 35.
  Home = 36, ---Value: 36.
  Left = 37, ---Arrow ←.
  Up = 38, ---Arrow ↑.
  Right = 39, ---Arrow →.
  Down = 40, ---Arrow ↓.
  Select = 41, ---Value: 41.
  Print = 42, ---Value: 42.
  Execute = 43, ---Value: 43.
  Snapshot = 44, ---Value: 44.
  Insert = 45, ---Value: 45.
  Delete = 46, ---Value: 46.
  Help = 47, ---Value: 47.
  LeftWin = 91, ---Value: 91.
  RightWin = 92, ---Value: 92.
  Apps = 93, ---Value: 93.
  Sleep = 95, ---Value: 95.
  NumPad0 = 96, ---Value: 96.
  NumPad1 = 97, ---Value: 97.
  NumPad2 = 98, ---Value: 98.
  NumPad3 = 99, ---Value: 99.
  NumPad4 = 100, ---Value: 100.
  NumPad5 = 101, ---Value: 101.
  NumPad6 = 102, ---Value: 102.
  NumPad7 = 103, ---Value: 103.
  NumPad8 = 104, ---Value: 104.
  NumPad9 = 105, ---Value: 105.
  Multiply = 106, ---Value: 106.
  Add = 107, ---Value: 107.
  Separator = 108, ---Value: 108.
  Subtract = 109, ---Value: 109.
  Decimal = 110, ---Value: 110.
  Divide = 111, ---Value: 111.
  F1 = 112, ---Value: 112.
  F2 = 113, ---Value: 113.
  F3 = 114, ---Value: 114.
  F4 = 115, ---Value: 115.
  F5 = 116, ---Value: 116.
  F6 = 117, ---Value: 117.
  F7 = 118, ---Value: 118.
  F8 = 119, ---Value: 119.
  F9 = 120, ---Value: 120.
  F10 = 121, ---Value: 121.
  F11 = 122, ---Value: 122.
  F12 = 123, ---Value: 123.
  F13 = 124, ---Value: 124.
  F14 = 125, ---Value: 125.
  F15 = 126, ---Value: 126.
  F16 = 127, ---Value: 127.
  F17 = 128, ---Value: 128.
  F18 = 129, ---Value: 129.
  F19 = 130, ---Value: 130.
  F20 = 131, ---Value: 131.
  F21 = 132, ---Value: 132.
  F22 = 133, ---Value: 133.
  F23 = 134, ---Value: 134.
  F24 = 135, ---Value: 135.
  NavigationView = 136, ---Reserved.
  NavigationMenu = 137, ---Reserved.
  NavigationUp = 138, ---Reserved.
  NavigationDown = 139, ---Reserved.
  NavigationLeft = 140, ---Reserved.
  NavigationRight = 141, ---Reserved.
  NavigationAccept = 142, ---Reserved.
  NavigationCancel = 143, ---Reserved.
  NumLock = 144, ---Value: 144.
  Scroll = 145, ---Value: 145.
  OemNecEqual = 146, ---“.
  OemFjJisho = 146, ---“Dictionary” key.
  OemFjMasshou = 147, ---“Unregister word” key.
  OemFjTouroku = 148, ---“Register word” key.
  OemFjLoya = 149, ---“Left OYAYUBI” key.
  OemFjRoya = 150, ---“Right OYAYUBI” key.
  LeftShift = 160, ---Value: 160.
  RightShift = 161, ---Value: 161.
  LeftControl = 162, ---Value: 162.
  RightControl = 163, ---Value: 163.
  LeftMenu = 164, ---Aka left Alt button.
  RightMenu = 165, ---Aka right Alt button.
  BrowserBack = 166, ---Value: 166.
  BrowserForward = 167, ---Value: 167.
  BrowserRefresh = 168, ---Value: 168.
  BrowserStop = 169, ---Value: 169.
  BrowserSearch = 170, ---Value: 170.
  BrowserFavorites = 171, ---Value: 171.
  BrowserHome = 172, ---Value: 172.
  VolumeMute = 173, ---Value: 173.
  VolumeDown = 174, ---Value: 174.
  VolumeUp = 175, ---Value: 175.
  MediaNextTrack = 176, ---Value: 176.
  MediaPrevTrack = 177, ---Value: 177.
  MediaStop = 178, ---Value: 178.
  MediaPlayPause = 179, ---Value: 179.
  LaunchMail = 180, ---Value: 180.
  LaunchMediaSelect = 181, ---Value: 181.
  LaunchApp1 = 182, ---Value: 182.
  LaunchApp2 = 183, ---Value: 183.
  Oem1 = 186, ---“;:” for US.
  OemPlus = 187, ---“+” any country.
  OemComma = 188, ---“,” any country.
  OemMinus = 189, ---“-” any country.
  OemPeriod = 190, ---“.” any country.
  Oem2 = 191, ---“/?” for US.
  Oem3 = 192, ---“`~” for US.
  GamepadA = 195, ---Reserved.
  GamepadB = 196, ---Reserved.
  GamepadX = 197, ---Reserved.
  GamepadY = 198, ---Reserved.
  GamepadRightShoulder = 199, ---Reserved.
  GamepadLeftShoulder = 200, ---Reserved.
  GamepadLeftTrigger = 201, ---Reserved.
  GamepadRightTrigger = 202, ---Reserved.
  GamepadDpadUp = 203, ---Reserved.
  GamepadDpadDown = 204, ---Reserved.
  GamepadDpadLeft = 205, ---Reserved.
  GamepadDpadRight = 206, ---Reserved.
  GamepadMenu = 207, ---Reserved.
  GamepadView = 208, ---Reserved.
  GamepadLeftThumbstickButton = 209, ---Reserved.
  GamepadRightThumbstickButton = 210, ---Reserved.
  GamepadLeftThumbstickUp = 211, ---Reserved.
  GamepadLeftThumbstickDown = 212, ---Reserved.
  GamepadLeftThumbstickRight = 213, ---Reserved.
  GamepadLeftThumbstickLeft = 214, ---Reserved.
  GamepadRightThumbstickUp = 215, ---Reserved.
  GamepadRightThumbstickDown = 216, ---Reserved.
  GamepadRightThumbstickRight = 217, ---Reserved.
  GamepadRightThumbstickLeft = 218, ---Reserved.
  SquareOpenBracket = 219, ---Value: 219.
  SquareCloseBracket = 221, ---Value: 221.
  D0 = 48, ---Digit 0.
  D1 = 49, ---Digit 1.
  D2 = 50, ---Digit 2.
  D3 = 51, ---Digit 3.
  D4 = 52, ---Digit 4.
  D5 = 53, ---Digit 5.
  D6 = 54, ---Digit 6.
  D7 = 55, ---Digit 7.
  D8 = 56, ---Digit 8.
  D9 = 57, ---Digit 9.
  A = 65, ---Letter A.
  B = 66, ---Letter B.
  C = 67, ---Letter C.
  D = 68, ---Letter D.
  E = 69, ---Letter E.
  F = 70, ---Letter F.
  G = 71, ---Letter G.
  H = 72, ---Letter H.
  I = 73, ---Letter I.
  J = 74, ---Letter J.
  K = 75, ---Letter K.
  L = 76, ---Letter L.
  M = 77, ---Letter M.
  N = 78, ---Letter N.
  O = 79, ---Letter O.
  P = 80, ---Letter P.
  Q = 81, ---Letter Q.
  R = 82, ---Letter R.
  S = 83, ---Letter S.
  T = 84, ---Letter T.
  U = 85, ---Letter U.
  V = 86, ---Letter V.
  W = 87, ---Letter W.
  X = 88, ---Letter X.
  Y = 89, ---Letter Y.
  Z = 90, ---Letter Z.
}

---More types might be added later, or at least a `CustomMode` type.
---@alias ac.SessionType
---| `ac.SessionType.Undefined` @Value: 0.
---| `ac.SessionType.Practice` @Value: 1.
---| `ac.SessionType.Qualify` @Value: 2.
---| `ac.SessionType.Race` @Value: 3.
---| `ac.SessionType.Hotlap` @Value: 4.
---| `ac.SessionType.TimeAttack` @Value: 5.
---| `ac.SessionType.Drift` @Value: 6.
---| `ac.SessionType.Drag` @Value: 7.
ac.SessionType = {
  Undefined = 0, ---Value: 0.
  Practice = 1, ---Value: 1.
  Qualify = 2, ---Value: 2.
  Race = 3, ---Value: 3.
  Hotlap = 4, ---Value: 4.
  TimeAttack = 5, ---Value: 5.
  Drift = 6, ---Value: 6.
  Drag = 7, ---Value: 7.
}

---@alias ac.SharedNamespace
---| `ac.SharedNamespace.Global` @Value: ''.
---| `ac.SharedNamespace.CarDisplay` @Value: 'car_scriptable_display'.
---| `ac.SharedNamespace.CarScript` @Value: 'car_script'.
---| `ac.SharedNamespace.TrackDisplay` @Value: 'track_scriptable_display'.
---| `ac.SharedNamespace.TrackScript` @Value: 'track_script'.
---| `ac.SharedNamespace.ServerScript` @Value: 'server_script'.
---| `ac.SharedNamespace.Shared` @Value: 'shared'.
ac.SharedNamespace = {
  Global = '', ---Value: ''.
  CarDisplay = 'car_scriptable_display', ---Value: 'car_scriptable_display'.
  CarScript = 'car_script', ---Value: 'car_script'.
  TrackDisplay = 'track_scriptable_display', ---Value: 'track_scriptable_display'.
  TrackScript = 'track_script', ---Value: 'track_script'.
  ServerScript = 'server_script', ---Value: 'server_script'.
  Shared = 'shared', ---Value: 'shared'.
}

---@alias ac.CompressionType
---| `ac.CompressionType.LZ4` @Fastest compression, great for use in real-time applications. Does not take `level` into account.
---| `ac.CompressionType.Deflate` @Deflate compression.
---| `ac.CompressionType.Zlib` @Zlib compression (deflate with zlib wrapper).
---| `ac.CompressionType.Gzip` @Gzip compression (deflate with gzip wrapper).
ac.CompressionType = {
  LZ4 = 0, ---Fastest compression, great for use in real-time applications. Does not take `level` into account.
  Deflate = 1, ---Deflate compression.
  Zlib = 2, ---Zlib compression (deflate with zlib wrapper).
  Gzip = 3, ---Gzip compression (deflate with gzip wrapper).
}

---@alias ac.NationCode
---| `ac.NationCode.Aruba` @Aruba.
---| `ac.NationCode.Afghanistan` @Afghanistan.
---| `ac.NationCode.Angola` @Angola.
---| `ac.NationCode.Anguilla` @Anguilla.
---| `ac.NationCode.Albania` @Albania.
---| `ac.NationCode.Andorra` @Andorra.
---| `ac.NationCode.United` @United.
---| `ac.NationCode.Argentina` @Argentina.
---| `ac.NationCode.Armenia` @Armenia.
---| `ac.NationCode.American` @American.
---| `ac.NationCode.Antarctica` @Antarctica.
---| `ac.NationCode.Antigua` @Antigua.
---| `ac.NationCode.Australia` @Australia.
---| `ac.NationCode.Austria` @Austria.
---| `ac.NationCode.Azerbaijan` @Azerbaijan.
---| `ac.NationCode.Burundi` @Burundi.
---| `ac.NationCode.Belgium` @Belgium.
---| `ac.NationCode.Benin` @Benin.
---| `ac.NationCode.Burkina` @Burkina.
---| `ac.NationCode.Bangladesh` @Bangladesh.
---| `ac.NationCode.Bulgaria` @Bulgaria.
---| `ac.NationCode.Bahrain` @Bahrain.
---| `ac.NationCode.Bahamas` @Bahamas.
---| `ac.NationCode.Bosnia` @Bosnia.
---| `ac.NationCode.Belarus` @Belarus.
---| `ac.NationCode.Belize` @Belize.
---| `ac.NationCode.Bermuda` @Bermuda.
---| `ac.NationCode.Bolivia` @Bolivia.
---| `ac.NationCode.Brazil` @Brazil.
---| `ac.NationCode.Barbados` @Barbados.
---| `ac.NationCode.Brunei` @Brunei.
---| `ac.NationCode.Bhutan` @Bhutan.
---| `ac.NationCode.Botswana` @Botswana.
---| `ac.NationCode.Central` @Central.
---| `ac.NationCode.Canada` @Canada.
---| `ac.NationCode.Cocos` @Cocos.
---| `ac.NationCode.Switzerland` @Switzerland.
---| `ac.NationCode.Chile` @Chile.
---| `ac.NationCode.China` @China.
---| `ac.NationCode.Cote` @Côte.
---| `ac.NationCode.Cameroon` @Cameroon.
---| `ac.NationCode.Congo` @Congo.
---| `ac.NationCode.Cook` @Cook.
---| `ac.NationCode.Colombia` @Colombia.
---| `ac.NationCode.Comoros` @Comoros.
---| `ac.NationCode.Cape` @Cape.
---| `ac.NationCode.Costa` @Costa.
---| `ac.NationCode.Cuba` @Cuba.
---| `ac.NationCode.Cayman` @Cayman.
---| `ac.NationCode.Cyprus` @Cyprus.
---| `ac.NationCode.Czech` @Czech.
---| `ac.NationCode.Germany` @Germany.
---| `ac.NationCode.Djibouti` @Djibouti.
---| `ac.NationCode.Dominica` @Dominica.
---| `ac.NationCode.Denmark` @Denmark.
---| `ac.NationCode.Dominican` @Dominican.
---| `ac.NationCode.Algeria` @Algeria.
---| `ac.NationCode.Ecuador` @Ecuador.
---| `ac.NationCode.Egypt` @Egypt.
---| `ac.NationCode.England` @England.
---| `ac.NationCode.Eritrea` @Eritrea.
---| `ac.NationCode.Western` @Western.
---| `ac.NationCode.Spain` @Spain.
---| `ac.NationCode.Estonia` @Estonia.
---| `ac.NationCode.Ethiopia` @Ethiopia.
---| `ac.NationCode.Finland` @Finland.
---| `ac.NationCode.Fiji` @Fiji.
---| `ac.NationCode.France` @France.
---| `ac.NationCode.Faroe` @Faroe.
---| `ac.NationCode.Micronesia` @Micronesia.
---| `ac.NationCode.Gabon` @Gabon.
---| `ac.NationCode.Great` @Great.
---| `ac.NationCode.Georgia` @Georgia.
---| `ac.NationCode.Guernsey` @Guernsey.
---| `ac.NationCode.Ghana` @Ghana.
---| `ac.NationCode.Gibraltar` @Gibraltar.
---| `ac.NationCode.Guinea` @Guinea.
---| `ac.NationCode.Gambia` @Gambia.
---| `ac.NationCode.Equatorial` @Equatorial.
---| `ac.NationCode.Greece` @Greece.
---| `ac.NationCode.Grenada` @Grenada.
---| `ac.NationCode.Greenland` @Greenland.
---| `ac.NationCode.Guatemala` @Guatemala.
---| `ac.NationCode.Guam` @Guam.
---| `ac.NationCode.Guyana` @Guyana.
---| `ac.NationCode.Hong` @Hong.
---| `ac.NationCode.Honduras` @Honduras.
---| `ac.NationCode.Croatia` @Croatia.
---| `ac.NationCode.Haiti` @Haiti.
---| `ac.NationCode.Hungary` @Hungary.
---| `ac.NationCode.Indonesia` @Indonesia.
---| `ac.NationCode.Isle` @Isle.
---| `ac.NationCode.India` @India.
---| `ac.NationCode.Ireland` @Ireland.
---| `ac.NationCode.Iran` @Iran.
---| `ac.NationCode.Iraq` @Iraq.
---| `ac.NationCode.Iceland` @Iceland.
---| `ac.NationCode.Israel` @Israel.
---| `ac.NationCode.Italy` @Italy.
---| `ac.NationCode.Jamaica` @Jamaica.
---| `ac.NationCode.Jersey` @Jersey.
---| `ac.NationCode.Jordan` @Jordan.
---| `ac.NationCode.Japan` @Japan.
---| `ac.NationCode.Kazakhstan` @Kazakhstan.
---| `ac.NationCode.Kenya` @Kenya.
---| `ac.NationCode.Kyrgyzstan` @Kyrgyzstan.
---| `ac.NationCode.Cambodia` @Cambodia.
---| `ac.NationCode.Kiribati` @Kiribati.
---| `ac.NationCode.Saint` @Saint.
---| `ac.NationCode.South` @South.
---| `ac.NationCode.Kuwait` @Kuwait.
---| `ac.NationCode.Laos` @Laos.
---| `ac.NationCode.Lebanon` @Lebanon.
---| `ac.NationCode.Liberia` @Liberia.
---| `ac.NationCode.Liechtenstein` @Liechtenstein.
---| `ac.NationCode.Sri` @Sri.
---| `ac.NationCode.Lesotho` @Lesotho.
---| `ac.NationCode.Lithuania` @Lithuania.
---| `ac.NationCode.Luxembourg` @Luxembourg.
---| `ac.NationCode.Latvia` @Latvia.
---| `ac.NationCode.Macau` @Macau.
---| `ac.NationCode.Morocco` @Morocco.
---| `ac.NationCode.Monaco` @Monaco.
---| `ac.NationCode.Moldova` @Moldova.
---| `ac.NationCode.Madagascar` @Madagascar.
---| `ac.NationCode.Maldives` @Maldives.
---| `ac.NationCode.Mexico` @Mexico.
---| `ac.NationCode.Marshall` @Marshall.
---| `ac.NationCode.Macedonia` @Macedonia.
---| `ac.NationCode.Mali` @Mali.
---| `ac.NationCode.Malta` @Malta.
---| `ac.NationCode.Myanmar` @Myanmar.
---| `ac.NationCode.Montenegro` @Montenegro.
---| `ac.NationCode.Mongolia` @Mongolia.
---| `ac.NationCode.Mozambique` @Mozambique.
---| `ac.NationCode.Mauritania` @Mauritania.
---| `ac.NationCode.Montserrat` @Montserrat.
---| `ac.NationCode.Martinique` @Martinique.
---| `ac.NationCode.Mauritius` @Mauritius.
---| `ac.NationCode.Malawi` @Malawi.
---| `ac.NationCode.Malaysia` @Malaysia.
---| `ac.NationCode.Namibia` @Namibia.
---| `ac.NationCode.New` @New.
---| `ac.NationCode.Niger` @Niger.
---| `ac.NationCode.Nigeria` @Nigeria.
---| `ac.NationCode.Nicaragua` @Nicaragua.
---| `ac.NationCode.Northern` @Northern.
---| `ac.NationCode.Netherlands` @Netherlands.
---| `ac.NationCode.Norway` @Norway.
---| `ac.NationCode.Nepal` @Nepal.
---| `ac.NationCode.Nauru` @Nauru.
---| `ac.NationCode.Oman` @Oman.
---| `ac.NationCode.Pakistan` @Pakistan.
---| `ac.NationCode.Panama` @Panama.
---| `ac.NationCode.Peru` @Peru.
---| `ac.NationCode.Philippines` @Philippines.
---| `ac.NationCode.Palau` @Palau.
---| `ac.NationCode.Papua` @Papua.
---| `ac.NationCode.Poland` @Poland.
---| `ac.NationCode.Puerto` @Puerto.
---| `ac.NationCode.Portugal` @Portugal.
---| `ac.NationCode.Paraguay` @Paraguay.
---| `ac.NationCode.French` @French.
---| `ac.NationCode.Qatar` @Qatar.
---| `ac.NationCode.Romania` @Romania.
---| `ac.NationCode.Russia` @Russia.
---| `ac.NationCode.Rwanda` @Rwanda.
---| `ac.NationCode.Saudi` @Saudi.
---| `ac.NationCode.Scotland` @Scotland.
---| `ac.NationCode.Sudan` @Sudan.
---| `ac.NationCode.Senegal` @Senegal.
---| `ac.NationCode.Singapore` @Singapore.
---| `ac.NationCode.Solomon` @Solomon.
---| `ac.NationCode.Sierra` @Sierra.
---| `ac.NationCode.El` @El.
---| `ac.NationCode.San` @San.
---| `ac.NationCode.Somalia` @Somalia.
---| `ac.NationCode.Serbia` @Serbia.
---| `ac.NationCode.Sao` @Sao.
---| `ac.NationCode.Suriname` @Suriname.
---| `ac.NationCode.Slovakia` @Slovakia.
---| `ac.NationCode.Slovenia` @Slovenia.
---| `ac.NationCode.Sweden` @Sweden.
---| `ac.NationCode.Swaziland` @Swaziland.
---| `ac.NationCode.Seychelles` @Seychelles.
---| `ac.NationCode.Syria` @Syria.
---| `ac.NationCode.Turks` @Turks.
---| `ac.NationCode.Chad` @Chad.
---| `ac.NationCode.Togo` @Togo.
---| `ac.NationCode.Thailand` @Thailand.
---| `ac.NationCode.Tajikistan` @Tajikistan.
---| `ac.NationCode.Turkmenistan` @Turkmenistan.
---| `ac.NationCode.Timor` @Timor.
---| `ac.NationCode.Tonga` @Tonga.
---| `ac.NationCode.Trinidad` @Trinidad.
---| `ac.NationCode.Tunisia` @Tunisia.
---| `ac.NationCode.Turkey` @Turkey.
---| `ac.NationCode.Tuvalu` @Tuvalu.
---| `ac.NationCode.Taiwan` @Taiwan.
---| `ac.NationCode.Tanzania` @Tanzania.
---| `ac.NationCode.Uganda` @Uganda.
---| `ac.NationCode.Ukraine` @Ukraine.
---| `ac.NationCode.Uruguay` @Uruguay.
---| `ac.NationCode.USA` @USA.
---| `ac.NationCode.Uzbekistan` @Uzbekistan.
---| `ac.NationCode.Venezuela` @Venezuela.
---| `ac.NationCode.British` @British.
---| `ac.NationCode.Virgin` @Virgin.
---| `ac.NationCode.Vietnam` @Vietnam.
---| `ac.NationCode.Vanuatu` @Vanuatu.
---| `ac.NationCode.Wales` @Wales.
---| `ac.NationCode.Samoa` @Samoa.
---| `ac.NationCode.Yemen` @Yemen.
---| `ac.NationCode.Zambia` @Zambia.
---| `ac.NationCode.Zimbabwe` @Zimbabwe.
ac.NationCode = {
  Aruba = 'ABW', ---Aruba.
  Afghanistan = 'AFG', ---Afghanistan.
  Angola = 'AGO', ---Angola.
  Anguilla = 'AIA', ---Anguilla.
  Albania = 'ALB', ---Albania.
  Andorra = 'AND', ---Andorra.
  United = 'ARE', ---United.
  Argentina = 'ARG', ---Argentina.
  Armenia = 'ARM', ---Armenia.
  American = 'ASM', ---American.
  Antarctica = 'ATA', ---Antarctica.
  Antigua = 'ATG', ---Antigua.
  Australia = 'AUS', ---Australia.
  Austria = 'AUT', ---Austria.
  Azerbaijan = 'AZE', ---Azerbaijan.
  Burundi = 'BDI', ---Burundi.
  Belgium = 'BEL', ---Belgium.
  Benin = 'BEN', ---Benin.
  Burkina = 'BFA', ---Burkina.
  Bangladesh = 'BGD', ---Bangladesh.
  Bulgaria = 'BGR', ---Bulgaria.
  Bahrain = 'BHR', ---Bahrain.
  Bahamas = 'BHS', ---Bahamas.
  Bosnia = 'BIH', ---Bosnia.
  Belarus = 'BLR', ---Belarus.
  Belize = 'BLZ', ---Belize.
  Bermuda = 'BMU', ---Bermuda.
  Bolivia = 'BOL', ---Bolivia.
  Brazil = 'BRA', ---Brazil.
  Barbados = 'BRB', ---Barbados.
  Brunei = 'BRN', ---Brunei.
  Bhutan = 'BTN', ---Bhutan.
  Botswana = 'BWA', ---Botswana.
  Central = 'CAF', ---Central.
  Canada = 'CAN', ---Canada.
  Cocos = 'CCK', ---Cocos.
  Switzerland = 'CHE', ---Switzerland.
  Chile = 'CHL', ---Chile.
  China = 'CHN', ---China.
  Cote = 'CIV', ---Côte.
  Cameroon = 'CMR', ---Cameroon.
  Congo = 'COG', ---Congo.
  Cook = 'COK', ---Cook.
  Colombia = 'COL', ---Colombia.
  Comoros = 'COM', ---Comoros.
  Cape = 'CPV', ---Cape.
  Costa = 'CRI', ---Costa.
  Cuba = 'CUB', ---Cuba.
  Cayman = 'CYM', ---Cayman.
  Cyprus = 'CYP', ---Cyprus.
  Czech = 'CZE', ---Czech.
  Germany = 'DEU', ---Germany.
  Djibouti = 'DJI', ---Djibouti.
  Dominica = 'DMA', ---Dominica.
  Denmark = 'DNK', ---Denmark.
  Dominican = 'DOM', ---Dominican.
  Algeria = 'DZA', ---Algeria.
  Ecuador = 'ECU', ---Ecuador.
  Egypt = 'EGY', ---Egypt.
  England = 'ENG', ---England.
  Eritrea = 'ERI', ---Eritrea.
  Western = 'ESH', ---Western.
  Spain = 'ESP', ---Spain.
  Estonia = 'EST', ---Estonia.
  Ethiopia = 'ETH', ---Ethiopia.
  Finland = 'FIN', ---Finland.
  Fiji = 'FJI', ---Fiji.
  France = 'FRA', ---France.
  Faroe = 'FRO', ---Faroe.
  Micronesia = 'FSM', ---Micronesia.
  Gabon = 'GAB', ---Gabon.
  Great = 'GBR', ---Great.
  Georgia = 'GEO', ---Georgia.
  Guernsey = 'GGY', ---Guernsey.
  Ghana = 'GHA', ---Ghana.
  Gibraltar = 'GIB', ---Gibraltar.
  Guinea = 'GNB', ---Guinea.
  Gambia = 'GMB', ---Gambia.
  Equatorial = 'GNQ', ---Equatorial.
  Greece = 'GRC', ---Greece.
  Grenada = 'GRD', ---Grenada.
  Greenland = 'GRL', ---Greenland.
  Guatemala = 'GTM', ---Guatemala.
  Guam = 'GUM', ---Guam.
  Guyana = 'GUY', ---Guyana.
  Hong = 'HKG', ---Hong.
  Honduras = 'HND', ---Honduras.
  Croatia = 'HRV', ---Croatia.
  Haiti = 'HTI', ---Haiti.
  Hungary = 'HUN', ---Hungary.
  Indonesia = 'IDN', ---Indonesia.
  Isle = 'IMN', ---Isle.
  India = 'IND', ---India.
  Ireland = 'IRL', ---Ireland.
  Iran = 'IRN', ---Iran.
  Iraq = 'IRQ', ---Iraq.
  Iceland = 'ISL', ---Iceland.
  Israel = 'ISR', ---Israel.
  Italy = 'ITA', ---Italy.
  Jamaica = 'JAM', ---Jamaica.
  Jersey = 'JEY', ---Jersey.
  Jordan = 'JOR', ---Jordan.
  Japan = 'JPN', ---Japan.
  Kazakhstan = 'KAZ', ---Kazakhstan.
  Kenya = 'KEN', ---Kenya.
  Kyrgyzstan = 'KGZ', ---Kyrgyzstan.
  Cambodia = 'KHM', ---Cambodia.
  Kiribati = 'KIR', ---Kiribati.
  Saint = 'VCT', ---Saint.
  South = 'ZAF', ---South.
  Kuwait = 'KWT', ---Kuwait.
  Laos = 'LAO', ---Laos.
  Lebanon = 'LBN', ---Lebanon.
  Liberia = 'LBR', ---Liberia.
  Liechtenstein = 'LIE', ---Liechtenstein.
  Sri = 'LKA', ---Sri.
  Lesotho = 'LSO', ---Lesotho.
  Lithuania = 'LTU', ---Lithuania.
  Luxembourg = 'LUX', ---Luxembourg.
  Latvia = 'LVA', ---Latvia.
  Macau = 'MAC', ---Macau.
  Morocco = 'MAR', ---Morocco.
  Monaco = 'MCO', ---Monaco.
  Moldova = 'MDA', ---Moldova.
  Madagascar = 'MDG', ---Madagascar.
  Maldives = 'MDV', ---Maldives.
  Mexico = 'MEX', ---Mexico.
  Marshall = 'MHL', ---Marshall.
  Macedonia = 'MKD', ---Macedonia.
  Mali = 'MLI', ---Mali.
  Malta = 'MLT', ---Malta.
  Myanmar = 'MMR', ---Myanmar.
  Montenegro = 'MNE', ---Montenegro.
  Mongolia = 'MNG', ---Mongolia.
  Mozambique = 'MOZ', ---Mozambique.
  Mauritania = 'MRT', ---Mauritania.
  Montserrat = 'MSR', ---Montserrat.
  Martinique = 'MTQ', ---Martinique.
  Mauritius = 'MUS', ---Mauritius.
  Malawi = 'MWI', ---Malawi.
  Malaysia = 'MYS', ---Malaysia.
  Namibia = 'NAM', ---Namibia.
  New = 'NZL', ---New.
  Niger = 'NER', ---Niger.
  Nigeria = 'NGA', ---Nigeria.
  Nicaragua = 'NIC', ---Nicaragua.
  Northern = 'NIR', ---Northern.
  Netherlands = 'NLD', ---Netherlands.
  Norway = 'NOR', ---Norway.
  Nepal = 'NPL', ---Nepal.
  Nauru = 'NRU', ---Nauru.
  Oman = 'OMN', ---Oman.
  Pakistan = 'PAK', ---Pakistan.
  Panama = 'PAN', ---Panama.
  Peru = 'PER', ---Peru.
  Philippines = 'PHL', ---Philippines.
  Palau = 'PLW', ---Palau.
  Papua = 'PNG', ---Papua.
  Poland = 'POL', ---Poland.
  Puerto = 'PRI', ---Puerto.
  Portugal = 'PRT', ---Portugal.
  Paraguay = 'PRY', ---Paraguay.
  French = 'PYF', ---French.
  Qatar = 'QAT', ---Qatar.
  Romania = 'ROU', ---Romania.
  Russia = 'RUS', ---Russia.
  Rwanda = 'RWA', ---Rwanda.
  Saudi = 'SAU', ---Saudi.
  Scotland = 'SCT', ---Scotland.
  Sudan = 'SDN', ---Sudan.
  Senegal = 'SEN', ---Senegal.
  Singapore = 'SGP', ---Singapore.
  Solomon = 'SLB', ---Solomon.
  Sierra = 'SLE', ---Sierra.
  El = 'SLV', ---El.
  San = 'SMR', ---San.
  Somalia = 'SOM', ---Somalia.
  Serbia = 'SRB', ---Serbia.
  Sao = 'STP', ---Sao.
  Suriname = 'SUR', ---Suriname.
  Slovakia = 'SVK', ---Slovakia.
  Slovenia = 'SVN', ---Slovenia.
  Sweden = 'SWE', ---Sweden.
  Swaziland = 'SWZ', ---Swaziland.
  Seychelles = 'SYC', ---Seychelles.
  Syria = 'SYR', ---Syria.
  Turks = 'TCA', ---Turks.
  Chad = 'TCD', ---Chad.
  Togo = 'TGO', ---Togo.
  Thailand = 'THA', ---Thailand.
  Tajikistan = 'TJK', ---Tajikistan.
  Turkmenistan = 'TKM', ---Turkmenistan.
  Timor = 'TLS', ---Timor.
  Tonga = 'TON', ---Tonga.
  Trinidad = 'TTO', ---Trinidad.
  Tunisia = 'TUN', ---Tunisia.
  Turkey = 'TUR', ---Turkey.
  Tuvalu = 'TUV', ---Tuvalu.
  Taiwan = 'TWN', ---Taiwan.
  Tanzania = 'TZA', ---Tanzania.
  Uganda = 'UGA', ---Uganda.
  Ukraine = 'UKR', ---Ukraine.
  Uruguay = 'URY', ---Uruguay.
  USA = 'USA', ---USA.
  Uzbekistan = 'UZB', ---Uzbekistan.
  Venezuela = 'VEN', ---Venezuela.
  British = 'VGB', ---British.
  Virgin = 'VIR', ---Virgin.
  Vietnam = 'VNM', ---Vietnam.
  Vanuatu = 'VUT', ---Vanuatu.
  Wales = 'WLS', ---Wales.
  Samoa = 'WSM', ---Samoa.
  Yemen = 'YEM', ---Yemen.
  Zambia = 'ZMB', ---Zambia.
  Zimbabwe = 'ZWE', ---Zimbabwe.
}

---@alias ac.CSPModuleID
---| `ac.CSPModuleID.BrakeDiscFX` @Brake Disc FX.
---| `ac.CSPModuleID.CarInstruments` @Car instruments.
---| `ac.CSPModuleID.ChaserCamera` @Chaser Camera.
---| `ac.CSPModuleID.ChatShortcuts` @Chat shortcuts.
---| `ac.CSPModuleID.ColorfulShadowing` @Colorful shadowing.
---| `ac.CSPModuleID.CustomRenderingModes` @Mode tweaks: custom.
---| `ac.CSPModuleID.DXGITweaks` @DXGI.
---| `ac.CSPModuleID.ExtraFX` @Extra FX.
---| `ac.CSPModuleID.FakeShadowsFX` @Fake Shadows FX.
---| `ac.CSPModuleID.FFBTweaks` @FFB Tweaks.
---| `ac.CSPModuleID.FreerCamera` @Freer Camera.
---| `ac.CSPModuleID.G27Lights` @Logitech G27.
---| `ac.CSPModuleID.General` @General Patch settings.
---| `ac.CSPModuleID.GraphicsAdjustments` @Graphic adjustments.
---| `ac.CSPModuleID.GrassFX` @Grass FX.
---| `ac.CSPModuleID.GUI` @GUI.
---| `ac.CSPModuleID.JoypadAssist` @Gamepad FX.
---| `ac.CSPModuleID.LightingFX` @Lighting FX.
---| `ac.CSPModuleID.LuaTools` @Lua_tools.
---| `ac.CSPModuleID.MumblePlugin` @Mumble_plugin.
---| `ac.CSPModuleID.Music` @Music.
---| `ac.CSPModuleID.NeckFX` @Neck FX.
---| `ac.CSPModuleID.NewBehaviour` @New AI behavior.
---| `ac.CSPModuleID.NewModes` @New Modes.
---| `ac.CSPModuleID.NiceScreenshots` @Nice Screenshots.
---| `ac.CSPModuleID.ParticlesFX` @Particles FX.
---| `ac.CSPModuleID.RainFX` @Rain FX.
---| `ac.CSPModuleID.ReflectionsFX` @Reflections FX.
---| `ac.CSPModuleID.ShadowedWheels` @Shadowed wheels.
---| `ac.CSPModuleID.SkidmarksFX` @Skidmarks FX.
---| `ac.CSPModuleID.SmallTweaks` @Small tweaks.
---| `ac.CSPModuleID.SmartMirror` @Smart Mirror.
---| `ac.CSPModuleID.SmartShadows` @Smart Shadows.
---| `ac.CSPModuleID.Splashscreen` @New loading screen.
---| `ac.CSPModuleID.Taskbar` @Taskbar.
---| `ac.CSPModuleID.TrackAdjustments` @Track adjustments.
---| `ac.CSPModuleID.TripleCustom` @Mode tweaks: Triple.
---| `ac.CSPModuleID.TyresFX` @Tyres FX.
---| `ac.CSPModuleID.VRTweaks` @Mode tweaks: VR.
---| `ac.CSPModuleID.WalkingOut` @Walking_out.
---| `ac.CSPModuleID.WeatherFX` @Weather FX.
---| `ac.CSPModuleID.WindscreenFX` @Windscreen FX.
---| `ac.CSPModuleID.Yebisest` @Yebisest.
ac.CSPModuleID = {
  BrakeDiscFX = 'brakedisc_fx', ---Brake Disc FX.
  CarInstruments = 'car_instruments', ---Car instruments.
  ChaserCamera = 'chaser_camera', ---Chaser Camera.
  ChatShortcuts = 'chat_shortcuts', ---Chat shortcuts.
  ColorfulShadowing = 'colorful_shadowing', ---Colorful shadowing.
  CustomRenderingModes = 'custom_rendering_modes', ---Mode tweaks: custom.
  DXGITweaks = 'dxgi_tweaks', ---DXGI.
  ExtraFX = 'extra_fx', ---Extra FX.
  FakeShadowsFX = 'fake_shadows_fx', ---Fake Shadows FX.
  FFBTweaks = 'ffb_tweaks', ---FFB Tweaks.
  FreerCamera = 'freer_camera', ---Freer Camera.
  G27Lights = 'g27_lights', ---Logitech G27.
  General = 'general', ---General Patch settings.
  GraphicsAdjustments = 'graphics_adjustments', ---Graphic adjustments.
  GrassFX = 'grass_fx', ---Grass FX.
  GUI = 'gui', ---GUI.
  JoypadAssist = 'joypad_assist', ---Gamepad FX.
  LightingFX = 'lighting_fx', ---Lighting FX.
  LuaTools = 'lua_tools', ---Lua_tools.
  MumblePlugin = 'mumble_plugin', ---Mumble_plugin.
  Music = 'music', ---Music.
  NeckFX = 'neck', ---Neck FX.
  NewBehaviour = 'new_behaviour', ---New AI behavior.
  NewModes = 'new_modes', ---New Modes.
  NiceScreenshots = 'nice_screenshots', ---Nice Screenshots.
  ParticlesFX = 'particles_fx', ---Particles FX.
  RainFX = 'rain_fx', ---Rain FX.
  ReflectionsFX = 'reflections_fx', ---Reflections FX.
  ShadowedWheels = 'shadowed_wheels', ---Shadowed wheels.
  SkidmarksFX = 'skidmarks_fx', ---Skidmarks FX.
  SmallTweaks = 'small_tweaks', ---Small tweaks.
  SmartMirror = 'smart_mirror', ---Smart Mirror.
  SmartShadows = 'smart_shadows', ---Smart Shadows.
  Splashscreen = 'splashscreen', ---New loading screen.
  Taskbar = 'taskbar', ---Taskbar.
  TrackAdjustments = 'track_adjustments', ---Track adjustments.
  TripleCustom = 'triple_custom', ---Mode tweaks: Triple.
  TyresFX = 'tyres_fx', ---Tyres FX.
  VRTweaks = 'vr_tweaks', ---Mode tweaks: VR.
  WalkingOut = 'walking_out', ---Walking_out.
  WeatherFX = 'weather_fx', ---Weather FX.
  WindscreenFX = 'windscreen_fx', ---Windscreen FX.
  Yebisest = 'yebisest', ---Yebisest.
}

---@alias ac.ObjectClass
---| `ac.ObjectClass.Any` @Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
---| `ac.ObjectClass.Node` @Regular children-holding objects.
---| `ac.ObjectClass.Model` @Track objects.
---| `ac.ObjectClass.CarNodeSorter` @An object holding cars.
---| `ac.ObjectClass.NodeBoundingSphere` @A wrapper for each car, skipping rendering if whole thing is not in frustum.
---| `ac.ObjectClass.IdealLine` @Ideal line.
---| `ac.ObjectClass.ParticleSystem` @Particle systems (don’t do much with ParticlesFX active).
---| `ac.ObjectClass.StaticParticleSystem` @Usually used for spectators.
---| `ac.ObjectClass.DisplayNode` @Display nodes for car dashboards.
---| `ac.ObjectClass.TextNode` @3D text nodes for car dashboards.
---| `ac.ObjectClass.CSPNode` @CSP nodes, for example fake shadow nodes.
---| `ac.ObjectClass.Renderable` @Refers to meshes and skinned meshes together.
---| `ac.ObjectClass.Mesh` @Regular meshes.
---| `ac.ObjectClass.SkinnedMesh` @Skinned meshes.
---| `ac.ObjectClass.SkidmarkBuffer` @Objects with skidmarks (don’t do much with SkidmarksFX active).
ac.ObjectClass = {
  Any = 0, ---Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
  Node = 1, ---Regular children-holding objects.
  Model = 2, ---Track objects.
  CarNodeSorter = 3, ---An object holding cars.
  NodeBoundingSphere = 4, ---A wrapper for each car, skipping rendering if whole thing is not in frustum.
  IdealLine = 7, ---Ideal line.
  ParticleSystem = 8, ---Particle systems (don’t do much with ParticlesFX active).
  StaticParticleSystem = 9, ---Usually used for spectators.
  DisplayNode = 10, ---Display nodes for car dashboards.
  TextNode = 11, ---3D text nodes for car dashboards.
  CSPNode = 12, ---CSP nodes, for example fake shadow nodes.
  Renderable = 13, ---Refers to meshes and skinned meshes together.
  Mesh = 15, ---Regular meshes.
  SkinnedMesh = 16, ---Skinned meshes.
  SkidmarkBuffer = 17, ---Objects with skidmarks (don’t do much with SkidmarksFX active).
}

---@alias ac.GamepadButton
---| `ac.GamepadButton.DPadUp` @Value: 0x1.
---| `ac.GamepadButton.DPadDown` @Value: 0x2.
---| `ac.GamepadButton.DPadLeft` @Value: 0x4.
---| `ac.GamepadButton.DPadRight` @Value: 0x8.
---| `ac.GamepadButton.Start` @Value: 0x10.
---| `ac.GamepadButton.Back` @Value: 0x20.
---| `ac.GamepadButton.LeftThumb` @Value: 0x40.
---| `ac.GamepadButton.RightThumb` @Value: 0x80.
---| `ac.GamepadButton.LeftShoulder` @Value: 0x100.
---| `ac.GamepadButton.RightShoulder` @Value: 0x200.
---| `ac.GamepadButton.A` @Value: 0x1000.
---| `ac.GamepadButton.B` @Value: 0x2000.
---| `ac.GamepadButton.X` @Value: 0x4000.
---| `ac.GamepadButton.Y` @Value: 0x8000.
---| `ac.GamepadButton.PlayStation` @Only for DualSense gamepads.
---| `ac.GamepadButton.Microphone` @Only for DualSense gamepads.
---| `ac.GamepadButton.Pad` @Only for DualSense gamepads.
ac.GamepadButton = {
  DPadUp = 0x1, ---Value: 0x1.
  DPadDown = 0x2, ---Value: 0x2.
  DPadLeft = 0x4, ---Value: 0x4.
  DPadRight = 0x8, ---Value: 0x8.
  Start = 0x10, ---Value: 0x10.
  Back = 0x20, ---Value: 0x20.
  LeftThumb = 0x40, ---Value: 0x40.
  RightThumb = 0x80, ---Value: 0x80.
  LeftShoulder = 0x100, ---Value: 0x100.
  RightShoulder = 0x200, ---Value: 0x200.
  A = 0x1000, ---Value: 0x1000.
  B = 0x2000, ---Value: 0x2000.
  X = 0x4000, ---Value: 0x4000.
  Y = 0x8000, ---Value: 0x8000.
  PlayStation = 0x10000, ---Only for DualSense gamepads.
  Microphone = 0x20000, ---Only for DualSense gamepads.
  Pad = 0x40000, ---Only for DualSense gamepads.
}

---@alias ac.GamepadAxis
---| `ac.GamepadAxis.LeftTrigger` @Value: 0.
---| `ac.GamepadAxis.RightTrigger` @Value: 1.
---| `ac.GamepadAxis.LeftThumbX` @Value: 2.
---| `ac.GamepadAxis.LeftThumbY` @Value: 3.
---| `ac.GamepadAxis.RightThumbX` @Value: 4.
---| `ac.GamepadAxis.RightThumbY` @Value: 5.
ac.GamepadAxis = {
  LeftTrigger = 0, ---Value: 0.
  RightTrigger = 1, ---Value: 1.
  LeftThumbX = 2, ---Value: 2.
  LeftThumbY = 3, ---Value: 3.
  RightThumbX = 4, ---Value: 4.
  RightThumbY = 5, ---Value: 5.
}

---@alias ac.GamepadType
---| `ac.GamepadType.None` @No gamepad in that slot.
---| `ac.GamepadType.XBox` @Regular XBox gamepad.
---| `ac.GamepadType.DualSense` @DualSense gamepad.
ac.GamepadType = {
  None = 0, ---No gamepad in that slot.
  XBox = 1, ---Regular XBox gamepad.
  DualSense = 2, ---DualSense gamepad.
}

---@alias ac.INIFormat
---| `ac.INIFormat.Default` @AC format: no quotes, “[” in value begins a new section, etc.
---| `ac.INIFormat.DefaultAcd` @AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
---| `ac.INIFormat.Extended` @Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
---| `ac.INIFormat.ExtendedIncludes` @Same as CSP, but also with support for INIpp expressions and includes.
ac.INIFormat = {
  Default = 0, ---AC format: no quotes, “[” in value begins a new section, etc.
  DefaultAcd = 1, ---AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
  Extended = 10, ---Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
  ExtendedIncludes = 11, ---Same as CSP, but also with support for INIpp expressions and includes.
}

--[[ common/common.lua ]]

---Path to a folder with currently running script.
---@type string
__dirname = nil

---Main CSP namespace.
ac = {}

---Get car tags. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string[]?
function ac.getCarTags(carIndex) end

---FFI-accelerated list, acts like a regular list (consequent items, size and capacity, automatically growing, etc.)
---Doesn’t store nil values to act more like a Lua table.
---
---For slightly better performance it might be benefitial to preallocate memory with `list:reserve(expectedSizeOrABitMore)`.
---@class ac.GenericList
local _ac_genericList = {}

---Number of items in the list.
---@return integer
function _ac_genericList:size() end

---Size of list in bytes (not capacity, for that use `list:capacityBytes()`).
---@return integer
function _ac_genericList:sizeBytes() end

---Checks if list is empty.
---@return boolean
function _ac_genericList:isEmpty() end

---Capacity of the list.
---@return integer
function _ac_genericList:capacity() end

---Size of list in bytes (capacity).
---@return integer
function _ac_genericList:capacityBytes() end

---Makes sure list can fit `newSize` of elements without reallocating memory.
---@param newSize integer
---@return integer
function _ac_genericList:reserve(newSize) end

---If capacity is greater than current size, reallocates a smaller bit of memory and moves data there.
function _ac_genericList:shrinkToFit() end

---Removes all elements.
function _ac_genericList:clear() end

--[[ common/class.lua ]]

---@alias ClassDefinition {__name: string}
---@alias ClassMixin {included: fun(classDefinition: ClassDefinition)}

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly.
ClassBase = {}

---Checks if object is an instance of a class created by `class()` function.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassBase` or any class inheriting from it.
function ClassBase.isInstanceOf(obj) end

---Checks if ClassBase is a subsclass of a class created by `class()` function. It wouldn’t be, function is here just for
---keeping things even.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @Always false.
function ClassBase:isSubclassOf(classDefinition) end

---Creates a new class. Pretty much the same as calling `class()` (all classes are inheriting from `ClassBase` anyway).
---@return ClassDefinition @New class definition
function ClassBase:subclass(...) end

---Adds a mixin to all subsequently created classes. Use it early in case you want to add a method or some data to all of your objects.
---If `mixin` has a property `included`, it would be called each time new class is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassBase:include(mixin) end

---Define this function and it would be called each time a new class without a parent (or `ClassBase` for parent) is created.
---@param classDefinition ClassDefinition
function ClassBase:subclassed(classDefinition) end

---A base class for objects with pooling. Note: all classes created with `class.Pool` flag are inheriting from this one even if they’re not using
---`ClassPool` as a parent class explicitly.
ClassPool = {}

---Checks if object is an instance of a class with pooling active.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassPool` or any class inheriting from it.
function ClassPool.isInstanceOf(obj) end

---Checks if ClassPool is a subsclass of a class created by `class()` function. It wouldn’t be unless you’re passing `ClassBase`, function is here just for
---keeping things even.
---@param classDefinition ClassBase @Class created by `class()` function.
---@return boolean @True if you’ve passed ClassBase here.
function ClassPool:isSubclassOf(classDefinition) end

---Creates a new class with pooling. Pretty much the same as calling `class(class.Pool, ...)` (all classes with `class.Pool` are 
---inheriting from `ClassPool` anyway).
---@return ClassDefinition @New class definition
function ClassPool:subclass(...) end

---Adds a mixin to subsequently created classes with pooling. Use it early in case you want to add a method or some data to all of your objects that use pooling.
---If `mixin` has a property `included`, it would be called each time new class with pooling is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassPool:include(mixin) end

---Define this function and it would be called each time a new pooling class without a parent (or `ClassPool` for parent) is created.
---@param classDefinition ClassDefinition
function ClassPool:subclassed(classDefinition) end

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly. You might still want to put it in EmmyDoc comment to get hints for functions like `YourClass.isInstanceOf()`.
---@class ClassBase
local _classBase = {}

---Checks if object is an instance of this class. Can be used either as `obj:isInstanceOf(YourClass)` or, as a safer alternative,
---`YourClass.isInstanceOf(obj)` — this one would work even if `obj` is nil, a number, a vector, anything like that. And in all of those
---cases, of course, it would return `false`.
---@param classDefinition ClassDefinition @Used with `obj:isInstanceOf(YourClass)` variant.
---@return boolean @True if argument is an instance of this class.
---@overload fun(): boolean
function _classBase:isInstanceOf(classDefinition) end

---Class method. Checks if class itself is a child class of a different class (or a child of a child, etc). 
---Can be used as `YourClass:isInstanceOf(YourOtherClass)`.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @True if this class is a child of another class (or a child of a child, etc).
function _classBase:isSubclassOf(classDefinition) end

---Class method. Includes mixin, adding new methods to a preexising class. If mixin has a property `included`, it will be called
---with an argument referencing a class mixin is being added to. Can be used as `YourClass:include({ newMethod = function(self, arg) end })`.
---@param mixin ClassMixin @Any mixin.
function _classBase:include(mixin) end

---Class method. Creates a new child class.
---@return ClassDefinition @New class definition
function _classBase:subclass(...) end

---Class method. Called when a new child class is created using this class as a parent one. Redefine this function for
---your class if you need some advanced processing, like adding new methods to a child class.
---@param classDefinition ClassDefinition @New class definition
function _classBase:subclassed(classDefinition) end

---A base class for objects with pooling. Doesn’t add anything, but you can add it as a parent class
---so that `recycled()` would be documented.
---@class ClassPool : ClassBase
local _classPool = {}

---Called when object is about to get recycled.
---@return boolean @Return false if this object should not be recycled and instead destroyed as usual.
function _classPool:recycled() end

---Create a new class. Example:
---
---```
---local MyClass = class('MyClass')        -- class declaration
---
---function MyClass:initialize(arg1, arg2) -- constructor
---  self.myField = arg1 + arg2            -- field
---end
---
---function MyClass:doMyThing()            -- method
---  print(self.myField)
---end
---
---local instance = MyClass(1, 2)          -- creating instance of a class
---instance:doMyThing()                    -- calling a method
---```
---
---Whole thing is very similar to [middleclass](https://github.com/kikito/middleclass), but it’s a different
---implementation that should be somewhat faster. Main differences:
---
---1. Class name is stored in `YourClass.__name` instead of `YourClass.name`.
---
---2. There is no `.static` subtable, all static fields and methods are instead stored in main class
---   table and thus are available as instance fields and methods as well (that’s why `YourClass.name` was
---   renamed to `YourClass.__name`, to avoid possible confusion with a common field name). It’s a bit
---   messier, especially with class methods such as `:subclass()`, but it has some advantages as well:
---   objects creation is faster, and it’s more EmmyLua-friendly (both of which is what it’s all about).
---
---3. Overloaded `__tostring`, `__len` and `__call` are inherited, but not other operators.
---
---4. Method `YourClass.allocate()` works differently here and is used to create a simple table which will be
---   passed to `setmetatable()`. This can help with performance if objects are created often.
---
---Everything else should work the same, including inheritance and mixins. As for performance, some simple
---tests show up to 30% faster objects creation and 40% less memory used for objects with two fields when
---using `YourClass.allocate()` method instead of `YourClass:initialize()` (that alone gives about 15% increase in speed
---when creating an object with two fields):
---
---```
---function YourClass.allocate(arg1, arg2)  -- notice . instead of :
---  return { myField = arg1 + arg2 }     -- also notice, methods are not available at this stage
---end
---```
---
---Other differences (new features rather than something breaking compatibility) and important notes:
---
---1. Function `class()` takes string for class name, another class to act like a parent,
---   allocate and initialize functions and flags. Everything is optional and can go in any order (with one caveat:
---   allocate function should go before initialize function unless you’re using `class.Pool`). Generally there is no
---   benefit in passing allocate and initialize functions here though.
---
---2. With flag `class.NoInitialize` constructor would not look for `YourClass:initialize()` method to call at all,
---   instead using only `YourClass.allocate()`. Might speed things up a bit further.
---
---3. If you’re creating new instances really often, there is a `class.Pool` flag. It would disable the use of
---   `YourClass.allocate()`, but instead allow to reuse unused objects by using `class.recycle(object)`. Recycled objects
---   would end up in a pool of objects to be reused next time an instance would need to be created. Of course, it
---   introduces a whole new type of errors (imagine storing a reference to a recycled item somewhere not knowing it was
---   recycled and now represents something else entirely), so please be careful.
---
---   Note 1: Method `class.recycle()` can be used with nils or non-recycle, no need to have extra checks before calling it.
--- 
---   Note 2: Instances of child classes won’t end up in parent class pool. For such arrangements, consider adding pooling
---           flag to all of child classes where appropriate.
---
---4. Before recycling, method `YourClass:recycled()` will be called. Good time to recycle any inner elements. Also,
---   return `false` from it and object would not be recycled at all.
---
---5. To check type, `YourClass.isInstanceOf(item)` can also be used. Notice that it’s a static method, no “:” here.
---
---All classes are considered children classes of `ClassBase`, that one is mostly for EmmyLua to pick up methods like 
---`YourClass.isInstanceOf(object)`. If you’re creating your own class and want to use such methods, just add `: ClassBase`
---to its EmmyLua annotation. And objects with pooling are children of `ClassPool` which is a child of `ClassBase`. Note: 
---to speed things up, those classes aren’t fully real, but you can access them and their methods and even call things like
---`ClassBase:include()`. Please read documentation for those functions before using them though, just to check.
---@param name string @Class name.
---@param parentClass ClassBase @Parent class.
---@param flags nil|integer|'class.NoInitialize'|'class.Pool'|'class.Minimal' @Flags.
---@overload fun(name: string, flags: nil|integer|'class.NoInitialize'|'class.Pool'|'class.Minimal')  @Regular parent-less class with some flags
---@overload fun(name: string, allocateFn: function|`function() return {} end, class.NoInitialize`)    @Inline allocate function for slightly faster creation
---@overload fun(name: string, initializeFn: `function (self) end, class.Pool`)               @With pooling for best memory reuse
---@overload fun(allocateFn: `function() return {} end, class.NoInitialize + class.Minimal`)  @Most minimal version
---@return ClassDefinition @New class definition
function class(name, parentClass, flags) end

class = {}

---Skip initialization function completely. Might slightly speed up object creation.
class.NoInitialize = 1

---Reuse recycled objects instead of creating new ones. Disables `.allocate()` and switches to `:initialize()`,
---but performance gain from not having to allocate new tables is worth it. Don’t forget to recycle unused elements
---with `class.recycle(item)`.
class.Pool = 2

---Minimal version of a class, skips creation of all static methods and default to-string operators.
---
---To use with either pooling or no-initialize setup, pass two flags separated by a comma, or just sum them together
---(would work only if values are powers of two and you’re not summing together the same flag twice). Or, use
---`bit.bor(flag1, flag2)`, courtesy of LuaJIT and its BitOp extension.
class.Minimal = 4

---Recycle an item to its pool, to speed up creation and reduce work for GC. Requires class to be created with
---`class.Pool` flag.
---
---This method has protection from double recycling, recycling nils or non-recycleable items, so don’t worry about it.
---@param item ClassPool|nil
function class.recycle(item) end

---A trick to get `class()` to work with EmmyLua annotations nicely. Call `class.emmy(YourClass, YourClass.initialize)`
---or `class.emmy(YourClass, YourClass.allocate)` (whatever you’re using) and it would give you a constructor function.
---Then, use it for local reference or as a return value from module. For best results add annotations to function you’re
---passing here, such as return value or argument types.
---
---In reality is simply returns the class back and ignores second argument, but because of this definition EmmyLua thinks
---it got the constructor.
---@generic T1
---@generic T2
---@param classFn T1
---@param constructorFn T2
---@return T1|T2
function class.emmy(classFn, constructorFn) return constructorFn end

--[[ csp.lua ]]

---Displays value in Lua Debug app, great for tracking state of your values live.
---@param key string
---@param value any?
function ac.debug(key, value) end

---Stops functions like `ac.log()` from logging things into CSP log file, in case you need to log a lot. With it, you
--- can use Lua Debug app to see latest log entries.
---@param value boolean? @Default value: `true`.
function ac.setLogSilent(value) end

---Prints message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
---@param value any?
function ac.log(value) end

---Prints message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
---@param value any?
function ac.warn(value) end

---Prints message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
---@param value any?
function ac.error(value) end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfBegin(value) end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfEnd(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameBegin(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameEnd(value) end

---Returns directory of the script.
---@return string
function ac.dirname() end

---If `fileName` is not an absolute path, looks for a file in script directory, then relative to CSP folder,
---then relative to AC root folder. If anything is found, returns an absolute path to found file, otherwise
---returns input parameter.
---@param fileName string @File name relative to script folder, or CSP folder, or AC root folder.
---@return string
function ac.findFile(fileName) end

---@return string?
function ac.getPatchVersion() end

---Increments with every CSP build.
---@return integer
function ac.getPatchVersionCode() end

---Returns full path to one of known folders.
---@param folderID ac.FolderID
---@return string
function ac.getFolder(folderID) end

---Use `ac.getTrackID()` instead.
---@deprecated
---@return string
function ac.getTrackId() end

---Returns track ID (name of its folder).
---@return string
function ac.getTrackID() end

---Returns track layout ID (name of layout folder, without name of track folder), or empty string if there is no layout.
---@return string
function ac.getTrackLayout() end

---Returns full track ID (name of track folder and layout folder joined by some string, or just name of track folder if there is no layout).
---@param separator string? @Default value: '-'.
---@return string
function ac.getTrackFullID(separator) end

---Returns track name (as set in its JSON file).
---@return string
function ac.getTrackName() end

---@return vec3
function ac.getCameraPosition() end

---@return vec3
function ac.getCameraUp() end

---@return vec3
function ac.getCameraSide() end

---@return vec3
function ac.getCameraForward() end

---This vector is pointing backwards! Only kept for compatibility. For proper one, use `ac.getCameraForward()`.
---@deprecated
---@return vec3
function ac.getCameraDirection() end

---Value in degrees.
---@return number
function ac.getCameraFOV() end

---@param r vec3 @Destination.
function ac.getCameraPositionTo(r) end

---@param r vec3 @Destination.
function ac.getCameraUpTo(r) end

---@param r vec3 @Destination.
function ac.getCameraSideTo(r) end

---@param r vec3 @Destination.
function ac.getCameraForwardTo(r) end

---@param r vec3 @Destination.
function ac.getCameraDirectionTo(r) end

---Returns camera position in car coordinates system.
---@return vec3
function ac.getCameraPositionRelativeToCar() end

---Returns compass angle for given directory.
---@param dir vec3
---@return number @Angle from 0 to 360 (0/360 for north, 90 for east, etc.)
function ac.getCompassAngle(dir) end

---Value in degrees.
---@return number
function ac.getSunAngle() end

---Value in degrees.
---@return number
function ac.getSunPitchAngle() end

---Value in degrees.
---@return number
function ac.getSunHeadingAngle() end

---Returns true if camera is focused on interior (interior audio is playing).
---@return boolean
function ac.isInteriorView() end

---@return boolean
function ac.isInReplayMode() end

---@param key string|nil @Default value: `nil`.
function ac.setTextureKey(key) end

---@param filename string
---@param outputFilename string
---@param key string
---@param applyLz4Compression boolean|`true`|`false`
function ac.encodeTexture(filename, outputFilename, key, applyLz4Compression) end

---@param filename string
---@param outputFilename string
function ac.compressTexture(filename, outputFilename) end

---Returns precalculated sound speed in m/s taking into account humidity, altitude, pressure, etc.
---@return number
function ac.getSoundSpeedMs() end

---Returns string with last error thrown by this script, or `nil` if there wasn’t an error. Use it in case you would want to set some nicer error reporting.
---@return string?
function ac.getLastError() end

---Turns time in milliseconds into common lap time presentation, like 00:00.123. If minutes exceed 60,
---hours will also be added, but only if `allow_hours` is `true` (default is `false`).
---@param time number
---@param allowHours boolean? @Set to `true` to add hours as well. If `false` (default value), instead it would produce 99:99.999. Default value: `false`.
---@return string
function ac.lapTimeToString(time, allowHours) end

---Returns country name based on nation code (three symbols for country ID).
---@param nationCode ac.NationCode
---@return string
function ac.getCountryName(nationCode) end

---Returns audio volume for given channel, value from 0 to 1. If channel is not recognized, returns -1.
---@param audioChannelKey ac.AudioChannel
---@return number @Value from 0 to 1.
function ac.getAudioVolume(audioChannelKey) end

---Consider using `ac.getCar(carIndex).speedKmh` instead.
---@param carIndex integer @0-based car index.
---@return number
function ac.getCarSpeedKmh(carIndex) end

---Returns approximate Y coordinate of ground, calculated by using depth from reflection cubemap. Does not have a performance impact (that value
--- will be calculated anyway for CSP to run.
---@return number
function ac.getGroundYApproximation() end

---Returns current delta time associated with UI (so values are non-zero if sim or replay are paused).
---@return number @Seconds.
function ac.getDeltaT() end

---Returns current delta time associated with simulation (so values are zero if sim or replay are paused).
---@return number @Seconds.
function ac.getGameDeltaT() end

---Returns delta time for current script. If script only runs every N frames (like car display scripts by default),
---this value will be greater than regular `dt` from simulation state.
---@return number
function ac.getScriptDeltaT() end

---Returns current time multiplier.
---@return number
function ac.getConditionsTimeScale() end

---Returns name of current PP filter with “.ini”.
---@return string?
function ac.getPpFilter() end

---Value is in m/s.
---@return vec3
function ac.getWindVelocity() end

---Value is in m/s.
---@param r vec3 @Destination.
function ac.getWindVelocityTo(r) end

---Can be used to access files in data.acd and, for example, read car specs
---@param value string
---@return string
function ac.readDataFile(value) end

---Parse INIpp configuration file, return it as JSON. Deprecated, use `ac.INIConfig.parse()` instead.
---@deprecated
---@param iniData string
---@return string
function ac.parseINIppFile(iniData) end

---Load and parse INIpp configuration file (supports includes and such), return it as JSON. Deprecated, use `ac.INIConfig.load()` instead.
---@deprecated
---@param iniFilename string
---@param includeDirs string|nil @Newline separated path to folders to search for included files in. Default value: `nil`.
---@return string?
function ac.loadINIppFile(iniFilename, includeDirs) end

---@return boolean
function ac.isWeatherFxActive() end

---Returns track world coordinates in degrees.
---@return vec2 @X for lattitude, Y for longitude.
function ac.getTrackCoordinatesDeg() end

---Returns timezone offset for the track in seconds.
---@return vec2 @X for base offset, Y for summer time offset.
function ac.getTrackTimezoneBaseDst() end

---Returns name of MGUK delivery program. If there is no such car or program, returns `nil`.
---@param carIndex integer @0-based car index.
---@param programIndex integer? @0-based program index (if negative, name of currently selected program will be returned. Default value: -1.
---@return string?
function ac.getMGUKDeliveryName(carIndex, programIndex) end

---Name of a sector.
---@param trackProgress number @Track position from 0 to 1.
---@return string
function ac.getTrackSectorName(trackProgress) end

---Distance and turn angle (in degrees) for the upcoming turn. If failed to compute, both would be -1. If car is facing wrong way, turn angle is either
---180° or -180° depending on where steering wheel of a car is.
---@param carIndex integer? @Default value: 0.
---@return vec2
function ac.getTrackUpcomingTurn(carIndex) end

---Get short name of a tyre set, either currently selected or with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@return string?
function ac.getTyresName(carIndex, compoundIndex) end

---Get 0-based index of a tyres set with a given short name, or -1 if there is no such tyres set (or such car).
---@param carIndex integer @0-based car index.
---@param tyresShortName string @Short tyres set name (usually a couple of symbols long).
---@return integer
function ac.getTyresIndex(carIndex, tyresShortName) end

---Returns long name of a tyre set with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@return string?
function ac.getTyresLongName(carIndex, compoundIndex) end

---Get car ID (name of its folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarID(carIndex) end

---Get car name (from its JSON file) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param includeYearPostfix boolean? @Set to `true` to add a year postfix. Default value: `false`.
---@return string?
function ac.getCarName(carIndex, includeYearPostfix) end

---Get selected skin ID of (name of skin’s folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarSkinID(carIndex) end

---Get name of a manufacturer of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarBrand(carIndex) end

---Get name of manufactoring country of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarCountry(carIndex) end

---Get full driver name of a driver of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverName(carIndex) end

---Get three character nation code of a driver of a certain car. Nation code is a three-letter uppercase country identifier. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “ITA” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverNationCode(carIndex) end

---Get full nationality of a driver of a certain car. Usually, it’s a full country name. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “Italy” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverNationality(carIndex) end

---Get name of a team of a driver of a certain car. Team names can be configured in entry list online. If nationality is not set, a value from JSON
---is returned. If it’s missing there, an empty string is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverTeam(carIndex) end

---Get number of a driver of a certain car. If number is set in skin JSON, it will be returned, otherwise it’s a unique 1-based number.
---If there is no car with such index, 0 is returned.
---@param carIndex integer @0-based car index.
---@return integer
function ac.getDriverNumber(carIndex) end

---Get session name for a session with given index. Use `ac.getSim()` to check number of sessions and more information about them.
---If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionName(sessionIndex) end

---Is keyboard button being held.
---@param keyIndex ac.KeyIndex
---@return boolean
function ac.isKeyDown(keyIndex) end

---Returns steering input from -1 to 1.
---@return number
function ac.getControllerSteerValue() end

---Is gas input pressed (pedal, gamepad axis, keyboard button but not mouse button).
---@return boolean
function ac.isControllerGasPressed() end

---Is gear up input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearUpPressed() end

---Is gear down input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearDownPressed() end

---Get session spawn set (`'START'`, `'PIT'`, `'HOTLAP_START'`, `'TIME_ATTACK'`, etc.) for a session with given index. Use `ac.getSim()`
---to check number of sessions and more information about them. If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionSpawnSet(sessionIndex) end

---Forces driver head to be visible even with cockpit camera.
---@param carIndex integer
---@param force boolean? @Default value: `true`.
function ac.forceVisibleHeadNodes(carIndex, force) end

---Refers to AI spline.
---@return boolean
function ac.hasTrackSpline() end

---Finds nearest point on track AI spline (fast_lane) and returns its normalized position. If there is no track spline, returns -1.
---@param v vec3
---@return number
function ac.worldCoordinateToTrackProgress(v) end

---Returns distance from AI spline to left and right track boundaries.
---@param v number @Lap progress from 0 to 1.
---@return vec2 @X for left side, Y for right side.
function ac.getTrackAISplineSides(v) end

---@param v number
---@return vec3
function ac.trackProgressToWorldCoordinate(v) end

---@param v number
---@param r vec3
function ac.trackProgressToWorldCoordinateTo(v, r) end

---Converts world coordinates into track coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.worldCoordinateToTrack(v) end

---Converts track coordinates into world coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.trackCoordinateToWorld(v) end

---Checks visibility with frustum culling.
---@param pos vec3
---@param radius number
---@return boolean
function ac.isVisibleInMainCamera(pos, radius) end

---@param msg string
---@param description string
function ac.setSystemMessage(msg, description) end

---Checks if a certain gamepad button is pressed.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadButtonID ac.GamepadButton
---@return boolean
function ac.isGamepadButtonPressed(gamepadIndex, gamepadButtonID) end

---Returns value of a certain gamepad axis.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadAxisID ac.GamepadAxis
---@return number
function ac.getGamepadAxisValue(gamepadIndex, gamepadAxisID) end

---Returns number of DirectInput devices (ignore misleading name).
---@return integer
function ac.getJoystickCount() end

---Returns name of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickName(joystick) end

---While this function returns accurate number of device axis, consider using 8 instead if you need to iterate over them.
---Actual axis can be somewhere within those 8. For example, if device has a single axis, it could be that you need to access
---axis at index seven to get its value (rest will be zeroes).
---@param joystick integer
---@return integer
function ac.getJoystickAxisCount(joystick) end

---Returns number of buttons of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickButtonsCount(joystick) end

---Returns number of D-pads (aka POVs) of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickDpadsCount(joystick) end

---Checks if a button of a DirectInput device is pressed (ignore misleading name).
---@param joystick integer
---@param button integer
---@return boolean
function ac.isJoystickButtonPressed(joystick, button) end

---Returns axis value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param axis integer
---@return number
function ac.getJoystickAxisValue(joystick, axis) end

---Use `ac.getJoystickAxisValue()` instead.
---@deprecated
---@param joystick integer
---@param axis integer
---@return number
function ac.isJoystickAxisValue(joystick, axis) end

---Returns D-pad (aka POV) value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param dpad integer
---@return integer
function ac.getJoystickDpadValue(joystick, dpad) end

---Use `ac.getJoystickDpadValue()` instead.
---@deprecated
---@param joystick integer
---@param dpad integer
---@return integer
function ac.isJoystickDpadValue(joystick, dpad) end

---Checks current stylus/pen/mouse using RealTimeStylus API (compatible with Windows Ink). Should support things like Wacom tables (if drivers are installed
---and Windows Ink compatibility in options is not disabled).
---
---Note: the moment its called, CSP initializes RealTimeStylus API to monitor pen state until game closes. With that, CSP will also use that data
---for mouse (or pen) pointer interaction with UI in general, especially for IMGUI apps.
---[There is a weird issue in Windows 10](https://answers.microsoft.com/en-us/windows/forum/all/windows-pen-tablet-click-and-drag-lag/9e4cac7d-69a0-4651-87e8-7689ce0d1027)
---where it doesn’t register short click-and-drag events properly expecting a touchscreen gesture. Using RealTimeStylus API for UI in general solves that.
---@return number @Pen pressure from 0 to 1 (if mouse is used, pressure is 1).
function ac.getPenPressure() end

---Sets diven text to the clipboard.
---@param text string
function ac.setClipboadText(text) end

---Given name, returns a path like …/assettocorsa/content/tracks/[track ID]/data/[name], taking into account layout as well.
---@param name string
---@return string
function ac.getTrackDataFilename(name) end

---Returns leaderboard car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarLeaderboardPosition(carIndex) end

---Returns real time car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`.
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarRealTimeLeaderboardPosition(carIndex) end

---Prints message to AC console.
---@param message string
---@param withoutPrefix boolean? @Default value: `false`.
function ac.console(message, withoutPrefix) end

---Show message using AC system messages UI.
---@param title string
---@param description string
function ac.setMessage(title, description) end

---How much of moon area is currently lit up.
---@return number
function ac.getMoonFraction() end

---@return number
function ac.getAltitude() end

---Get direction to a sky feature in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param skyFeature ac.SkyFeature
---@param distance number|refnumber|nil @Default value: `nil`.
---@return vec3
function ac.getSkyFeatureDirection(skyFeature, distance) end

---Get direction to a star in the sky in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param declRad number
---@param rightAscRad number
---@return vec3
function ac.getSkyStarDirection(declRad, rightAscRad) end

---Returns name of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerName() end

---Returns IP address of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerIP() end

---Returns HTTP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortHTTP() end

---Returns TCP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortTCP() end

---Returns UDP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortUDP() end

---Checks if a user is tagged as a friend. Uses CSP and CM databases.
---@param username string
---@return boolean
function ac.isTaggedAsFriend(username) end

---Tags user as a friend (or removes the tag if `false` is passed).
---@param username string
---@param isFriend boolean? @Default value: `true`.
function ac.tagAsFriend(username, isFriend) end

---Call this function if your script caused car shape to change and CSP would refresh interior masking, car heightmap and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarShape(carIndex) end

---Call this function if your script caused car color to change and CSP would refresh color map for bounced light and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarColor(carIndex) end

---Updates state of high-res driver model. Use it before moving driver nodes manually for extra animations: if called,
--- next model update possibly overwriting your custom positioning will be skipped. Also, model update will be enforced
--- so you can blend your custom state.
---@param carIndex integer? @For car scripts, always applied to associated car instead. Default value: -1.
function ac.updateDriverModel(carIndex) end

---Encodes float into FP16 format and returns it as uint16.
---@param v number
---@return integer
function ac.encodeHalf(v) end

---Encodes two floats from a vector into FP16 format and returns it as uint32.
---@param v vec2
---@return integer
function ac.encodeHalf2(v) end

---Decodes float from FP16 format (represented as uint16) and returns a regular number.
---@param v integer
---@return number
function ac.decodeHalf(v) end

---Decodes two floats from FP16 format (represented as uint32) and returns a vector.
---@param v integer
---@return vec2
function ac.decodeHalf2(v) end

---Sets a callback which will be called when a new session starts (or restarts).
---@param callback fun(sessionIndex: integer, restarted: boolean) @Callback function.
---@return ac.Disposable
function ac.onSessionStart(callback) end

---Sets a callback which will be called when car teleports somewhere or its state gets reset.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all car.
---@param callback fun(carID: integer) @Callback function.
---@return ac.Disposable
function ac.onCarJumped(carIndex, callback) end

---Sets a callback which will be called when new user connects the server and their car appears (doesn’t do anything outside of online race).
---@param callback fun(connectedCarIndex: integer, connectedSessionID: integer) @Callback function.
---@return ac.Disposable
function ac.onClientConnected(callback) end

---Sets a callback which will be called when a user disconnects (doesn’t do anything outside of online race).
---@param callback fun(connectedCarIndex: integer, connectedSessionID: integer) @Callback function.
---@return ac.Disposable
function ac.onClientDisconnected(callback) end

---Sets a callback which will be called when control settings change live.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onControlSettingsChanged(callback) end

---Sets a callback which will be called when folder contents change.
---@param folder string @Full path to a directory to monitor.
---@param filter string @CSP filter (? for any number of any symbols, regex if “`” quotes are used, or a complex query) applied to full file path, or `nil`.
---@param recursive boolean|`true`|`false` @If `true`, changes in subfolders are also detected.
---@param callback fun(files: string[]) @Callback function.
---@return ac.Disposable
function ac.onFolderChanged(folder, filter, recursive, callback) end

---Sets a callback which will be called when config for certain CSP module has changed.
---@param cspModuleID ac.CSPModuleID @ID of a module to monitor.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onCSPConfigChanged(cspModuleID, callback) end

---Sets a callback which will be called when a new screenshot is made.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onScreenshot(callback) end

---Computes SHA-256 checksum for given binary data. Very secure, but might be slow with large amounts of data. Data string can contain zeroes.
---@param data string|any
---@return string?
function ac.checksumSHA256(data) end

---Computes 64-bit xxHash checksum for given binary data. Very fast, not that great for encryption purposes.
---Use `bit.tohex()` to turn result into a hex representation. Data string can contain zeroes.
---@param data string|any
---@return integer
function ac.checksumXXH(data) end

---A key unique for each individual PC (uses serial numbers of processor and motherboard).
---@return string
function ac.uniqueMachineKey() end

---Compresses data. First byte of resulting data is compression type, next four are uncompressed data size, rest is compressed data
---itself. If data is failed to compress, returns `nil`. Data string can contain zeroes.
---@param data string|any
---@param type ac.CompressionType
---@param level integer? @Higher level means better, but slower compression. Maximum value: 12. Default value: 9.
---@return string?
function ac.compress(data, type, level) end

---Decompresses data. First byte of input data is compression type, next four are uncompressed data sizea. If data is damaged, returns `nil`.
---Data string can contain zeroes.
---@param data string|any
---@return string?
function ac.decompress(data) end

---Encodes data in base64 format. Data string can contain zeroes.
---@param data string|any
---@param trimResult boolean? @If `true`, ending “=” will be trimmed. Default value: `false`.
---@return string?
function ac.encodeBase64(data, trimResult) end

---Decodes data from base64 format (ending “=” are not needed).
---@param data string
---@return string?
function ac.decodeBase64(data) end

---Converts string from UTF-8 to UTF-16 format (two symbols per character). All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes.
---@param data string
---@return string?
function ac.utf8To16(data) end

---Converts string from UTF-16 (two symbols per character) to common Lua UTF-8. All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes. Data string can contain zeroes.
---@param data string|any
---@return string?
function ac.utf16To8(data) end

---Broadcasts a shared event. With shared events, different Lua scripts can exchange messages and data.
---
---Callbacks will be called next time this script is updating.
---
---Note: if your scripts need to exchange data often, consider using `ac.connect()` instead, as it allows to establish a typed connection
---with much less overhead.
---
---Data might contain zeroes.
---@param key string
---@param data string|any
---@return integer @Returns number of listeners to the event with given key.
function ac.broadcastSharedEvent(key, data) end

---Subscribes to a shared event. With shared events, different Lua scripts can exchange messages and data.
---
---Callback will be called next time this script is updating.
---@param key string
---@param callback fun(data: string|nil, senderName: string, senderType: string) @Callback function. Data might be `nil`.
---@return ac.Disposable
function ac.onSharedEvent(key, callback) end

---@param hand integer @0 for left, 1 for right.
---@param busy boolean|`true`|`false` @Busy hand doesn’t have visual marks and doesn’t interact with UI and car elements.
function ac.setVRHandBusy(hand, busy) end

---@param hand integer @0 for left, 1 for right.
---@param frequency number
---@param amplitude number
---@param duration number? @Duration in seconds. Default value: 0.01.
function ac.setVRHandVibration(hand, frequency, amplitude, duration) end

---Returns index of a car in front of other car (within 100 m), or -1 if there is no such car.
---@param carMainIndex integer
---@param distance number|refnumber|nil @Default value: `nil`.
---@return integer
function ac.getCarIndexInFront(carMainIndex, distance) end

---Calculates time gap between two cars in seconds. In race sessions uses total driven distance and main car speed, in other sessions simply
---compares best lap times. If main car is ahead of comparing-to car (in front of, or has better lap time for non-race sessions), value will
---be negative.
---
---In the future implementation might change for something more precise.
---@param carMainIndex integer @0-based index.
---@param carComparingToIndex integer @0-based index.
---@return number
function ac.getGapBetweenCars(carMainIndex, carComparingToIndex) end

---Gets file attributes.
---@param filename string
---@return io.FileAttributes
function io.getAttributes(filename) end

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`. Asyncronous version.
---@param filename string
---@param callback fun(err: string, data: string)
function io.loadAsync(filename, callback) end

---Writes data into a file, returns `true` if operation was successfull. Data string can contain zeroes.
---@param filename string
---@param data string|any
---@return boolean
function io.save(filename, data) end

---Writes data into a file from a different thread, returns `true` via callback if operation was successfull. Data string can contain zeroes.
---@param filename string
---@param data string|any
---@param callback fun(err: string)
function io.saveAsync(filename, data, callback) end

---Checks if file or directory exists. If you need to know specifically if a file or directory exists, use `io.dirExists(filename)` or `io.fileExists(filename)`.
---@param filename string
---@return boolean
function io.exists(filename) end

---Checks if directory exists. If there is a file in its place, it would return `false`.
---@param filename string
---@return boolean
function io.dirExists(filename) end

---Checks if file exists. If there is a directory in its place, it would return `false`.
---@param filename string
---@return boolean
function io.fileExists(filename) end

---Calculates file size in bytes. Returns -1 if there was an error.
---@param filename string
---@return integer
function io.fileSize(filename) end

---Returns creation time as number of seconds since 1970, or -1 if there was an error.
---@param filename string
---@return integer
function io.creationTime(filename) end

---Returns last access time as number of seconds since 1970, or -1 if there was an error.
---@param filename string
---@return integer
function io.lastAccessTime(filename) end

---Returns last write time as number of seconds since 1970, or -1 if there was an error.
---@param filename string
---@return integer
function io.lastWriteTime(filename) end

---Creates new directory, returns `true` if directory was created. If parent directories are missing, they’ll be created as well.
---@param filename string
---@return boolean
function io.createDir(filename) end

---Checks if file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does not allow slashes).
---@param fileName string
---@return boolean
function io.isFileNameAcceptable(fileName) end

---Checks if full file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does allow slashes).
---@param filename string
---@return boolean
function io.isFilePathAcceptable(filename) end

---Moves a file or a directory with all of its contents to a new place, returns `true` if moved successfully. Can be used for moving or renaming things.
---@param existingFilename string
---@param newFilename string
---@return boolean
function io.move(existingFilename, newFilename) end

---Copies a file to a new place, returns `true` if moved successfully.
---@param existingFilename string
---@param newFilename string
---@param failIfExists boolean? @Set to `false` to silently overwrite existing files. Default value: `true`.
---@return boolean
function io.copyFile(existingFilename, newFilename, failIfExists) end

---Deletes a file, returns `true` if file was deleted successfully. To delete empty directory, use `io.deleteDir()`. If you’re operating around important
---files, consider using `io.recycle()` instead.
---@param filename string
---@return boolean
function io.deleteFile(filename) end

---Deletes an empty directory, returns `true` if directory was deleted successfully. To delete a file, use `io.deleteFile()`.
---@param filename string
---@return boolean
function io.deleteDir(filename) end

---Moves file to Windows Recycle Bin, returns `true` if file was moved successfully. Note: this operation is much slower than removing a file with `io.deleteFile()`
---or removing an empty directory with `io.deleteDir()`.
---@param filename string
---@return boolean
function io.recycle(filename) end

---Loads file from an archive as a string. Archive would remain open for some time to speed up consequent reads. If failed, returns `nil`.
---@param zipFilename string
---@param entryFilename string
---@return string?
function io.loadFromZip(zipFilename, entryFilename) end

---Computes SHA-256 checksum of a given file, returns result in a callback.
---@param filename string
---@param callback fun(err: string, checksum: string)
function io.checksumSHA256(filename, callback) end

---Returns formatted date. Same as `os.date()`, but returned value does not include system timezome.
---@param format string
---@param timestamp integer
---@return string
function os.dateGlobal(format, timestamp) end

---Adds new directory to look for DLL files in.
---@param filename string @If not absolute, considered to be relative to script root folder.
function os.addDLLDirectory(filename) end

---Altered version of regular `os.execute()`: allows to specify timeout and doesn’t show a new window.
--- Note: please consider using `os.runConsoleProcess()` instead: it’s a lot more robust, asyncronous and tweakable.
---@param cmd string
---@param timeoutMs integer? @Default value: -1.
---@param windowless boolean? @Default value: `true`.
---@return integer
function os.execute(cmd, timeoutMs, windowless) end

---Show a popup message using good old MessageBox. Please do not use it for debugging, instead consider using `ac.log()` and `ac.debug('key', 'value')`
---with in-game Lua Debug App.
---@param msg string
---@param type integer? @Type of MessageBox according to WinAPI. Default value: 0.
---@return integer
function os.showMessage(msg, type) end

---Shows file in Windows Explorer (opens folder with it and selects the file).
---@param filename string
function os.showInExplorer(filename) end

---Opens file or directory in Windows Explorer. If it’s a file, associated program will be launched instead.
---@param directory string
function os.openInExplorer(directory) end

---Tries to find a program associated with a filename. Returns path to it, or `nil` if nothing was found.
---@param filename string
---@return string?
function os.findAssociatedExecutable(filename) end

---Opens text file at given line in a default text editor. Supports VS Code, Notepad++, Sublime Text and Atom (they all use different
---arguments for line number.
---@param filename string
---@param line integer
function os.openTextFile(filename, line) end

---Opens URL in default system browser.
---@param url string
function os.openURL(url) end

---Sets a callback which will be called when album cover changes.
---@param callback fun(hasCover: boolean)
---@return ac.Disposable
function ac.onAlbumCoverUpdate(callback) end

---Returns audio peak level for the system, for left and right channels. Careful: AC audio is also included, but
---it still might be used to fake some audio visualization.
---@return vec2
function ac.mediaCurrentPeak() end

---Switches to the next track in currently active music player (by simulating media key press).
function ac.mediaNextTrack() end

---Switches to the previous track in currently active music player (by simulating media key press).
function ac.mediaPreviousTrack() end

---Pauses or unpauses current track in currently active music player (by simulating media key press).
function ac.mediaPlayPause() end

---Returns floading point number of seconds since 1970/01/01 that can be used for driving track animations in such a way that if time multiplier is set to
---0 or above 1, things would still happen at normal speed, although out of sync with the clock. Ensures to keep things online as well. Currently might not
---work that well with replays, futher updates will improve some edge cases.
---
---Note: if time is still being estimated, returns 0, be sure to check for that case.
---@return number
function ac.getTrackDateTime() end

---Use `ac.getSim()` instead
---@deprecated
---@return ac.StateSim
function ac.getSimState() end

---Use `ac.getUI()` instead
---@deprecated
---@return ac.StateUi
function ac.getUiState() end

---Use `ac.getCar()` instead. Here, index starts with 1! With `ac.getCar()` index starts with 0, to match the rest of API functions
---@param index integer @1-based index.
---@return ac.StateCar?
function ac.getCarState(index) end

---Returns reference to a structure with various information about the state of Assetto Corsa. Very cheap to use.
--- This is a new version with shorter name.
---@return ac.StateSim
function ac.getSim() end

---Returns reference to a structure with various information about certain session. Very cheap to use.
---@param index integer @0-based index.
---@return ac.StateSession?
function ac.getSession(index) end

---Returns reference to a structure with various information about the state of the UI. Very cheap to use.
---This is a new version with shorter name.
---
---Note: this information is about AC UI, not about, for example, a dynamic track texture you might be updating.
---@return ac.StateUi
function ac.getUI() end

---Returns reference to a structure with various information about the state of a car. Very cheap to use.
---This is a new version with shorter name and 0-based indexing (to match other API functions).
---
---Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
---with index 0 is always there.
---@param index integer @0-based index.
---@return ac.StateCar?
function ac.getCar(index) end

---Returns reference to a structure with VR-related values, like hands and head positions. Very cheap to use.
---
---Note: currently, accurate values are available with Oculus only.
---@return ac.StateVr?
function ac.getVR() end

---Returns additional details on physics state of a car. Not available in replays or for remote cars.
---
---Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
---with index 0 is always there.
---@param index integer @0-based index.
---@return ac.StateCarPhysics?
function ac.getCarPhysics(index) end

---Returns extras of PS5 DualSense gamepad, such as accelerometer, gyroscope or battery state.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@return ac.StateDualsense?
function ac.getDualSense(gamepadIndex) end

---Returns a structure with state of PS5 DualSense LEDs, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param priority number? @If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.
---@param holdFor number? @Time to keep the changes for in seconds. Default value: 0.5.
---@return ac.StateDualsenseOutput @Returns `nil` if there is no applicable controller, make sure to check for it.
function ac.setDualSense(gamepadIndex, priority, holdFor) end

---Loads a ZIP file from a given URL, unpacks first KN5 from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to load
---KN5 in the scene.
---
---If there is a VAO patch in a ZIP file, it will be extracted next to KN5.
---
---Note: only valid KN5 files and VAO patches are supported. Heavy caching is applied: if model was
---downloaded once, it would not be re-downloaded (unlike with remote textures where proper HTTP caching
---rules apply). If model was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `ac.loadRemoteAssets()` instead.
---@deprecated
---@param url string @URL to download.
---@param callback fun(err: string, filename: string)
function web.loadRemoteModel(url, callback) end

---Loads a ZIP file from a given URL, unpacks first KsAnim from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to animate
---objects in the scene. If animation was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `ac.loadRemoteAssets()` instead.
---@deprecated
---@param url string @URL to download.
---@param callback fun(err: string, filename: string)
function web.loadRemoteAnimation(url, callback) end

---Loads a ZIP file from a given URL, unpacks assets from it to a cache folder and returns
---path to the folder in a callback. If files are already in cache storage, doesn’t do anything and
---simply returns the path. After callback is called, you can use path to the folder to get full paths to those assets.
---If assets are not accessed for a couple of weeks, they’ll be removed.
---@param url string @URL to download.
---@param callback fun(err: string, folder: string)
function web.loadRemoteAssets(url, callback) end

---@param key string
---@return string
function web.encryptKey(key) end
---@class ac.StateWheel : ClassBase
---@field tyreRadius number @Tyre radius in meters.
---@field tyreWidth number @Tyre width in meters.
---@field rimRadius number @Rim radius in meters (older cars might not have it).
---@field tyreDirty number @Dirt levels for tyres, four values, from 0 to 1.
---@field tyreWear number @Tyre wear, from 0 to 1.
---@field tyreVirtualKM number @Driven distance for each tyre in km (resets when tyres change, not an actual distance, rate of change depends on wear multiplier).
---@field tyreGrain number
---@field tyreBlister number
---@field tyreFlatSpot number
---@field tyreStaticPressure number @Static tyre pressure.
---@field tyrePressure number @Dynamic tyre pressure.
---@field temperatureMultiplier number
---@field tyreCoreTemperature number @Core tyre temperature, in °C.
---@field tyreInsideTemperature number @Inside tyre temperature, in °C.
---@field tyreMiddleTemperature number @Middle tyre temperature, in °C.
---@field tyreOutsideTemperature number @Outside tyre temperature, in °C.
---@field tyreOptimumTemperature number @Optimum tyre temperature, in °C.
---@field discTemperature number
---@field angularSpeed number
---@field slip number
---@field slipAngle number @Angle between the desired direction and the actual direction of the vehicle, in degrees.
---@field slipRatio number
---@field ndSlip number
---@field load number @Tyre load in N (warning: does not have correct values for remote cars online or in replays, use `.loadK` if you want a rough but stable estimation instead)
---@field loadK number @Rough estimation of tyre load which works stable for remote cars or in replays, goes from 0 (no load) to 1 (full load).
---@field camber number @Camber angle in degrees.
---@field toeIn number @Toe angle in degrees.
---@field suspensionDamage number
---@field suspensionTravel number
---@field tyreLoadedRadius number
---@field waterThickness number @Water thickness in meters.
---@field dx number
---@field dy number
---@field mz number @Self aligning torque.
---@field fx number
---@field fy number
---@field contactNormal vec3 @Normal of a contact point surface.
---@field contactPoint vec3 @Contact point position in world coordinates.
---@field position vec3 @Wheel position in world coordinates.
---@field look vec3 @Wheel heading vector.
---@field up vec3 @Wheel vector directed upwards.
---@field outside vec3 @Points outside of car (to the left of tyre for left tyres, to the right for right).
---@field velocity vec3
---@field transform mat4x4 @Wheel transformation.
---@field surfaceDirt number @Dirt additive coefficient of the surface below the wheel.
---@field surfaceSectorID integer @Sector ID of the surface below the wheel.
---@field surfaceGrip number @Grip of the surface below the wheel.
---@field surfaceDamping number @Damping of the surface below the wheel.
---@field surfaceGranularity number @Damping of the surface below the wheel.
---@field surfaceVibrationGain number @Vibration gain of the surface below the wheel.
---@field surfaceVibrationLength number @Vibration length of the surface below the wheel.
---@field surfacePitlane boolean @If surface below the wheel is in pitlane.
---@field surfaceValidTrack boolean @If surface below the wheel is valid track.
---@field isBlown boolean
---@field isHot boolean
---@field surfaceType ac.SurfaceType

---@class ac.StateCar : ClassBase
---@field mass number @Car mass in kg.
---@field steerLock number @Maximum steering wheel angle in degrees.
---@field maxFuel number @Maximum amount of fuel in liters.
---@field exposureOutside number @Outboard exposure from car.ini
---@field exposureInside number @Onboard exposure from car.ini
---@field shakeMultiplier number @SHAKE_MUL value from car.ini
---@field aabbCenter vec3 @Center of AABB (calculated from LOD D or collider mesh).
---@field aabbSize vec3 @Size of AABB in meters (calculated from LOD D or collider mesh).
---@field index integer @0-based (0 for first car).
---@field gearCount integer @Physics-only (see `ac.CarState.physicsAvailable`)
---@field turboCount integer @Physics-only (see `ac.CarState.physicsAvailable`)
---@field tractionType integer @0 for rwd, 1 for fwd, 2 for awd, 3 for new awd, -1 for N/A. Physics-only (see `ac.CarState.physicsAvailable`)
---@field enginePosition integer @0 for unspecified, 1 for front, 2 for rear, 3 for mid. Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasLimitDown number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasLimitUp number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasStep number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field year integer @Manufactoring year.
---@field hShifter boolean @True if car has H-shifter in its physics data.
---@field adjustableTurbo boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesCockpitBias boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field extrapolatedMovement boolean @If set to false and you’re adding objects moving close to cars, use ac.CarState.timestamp to estimate dt in such a way that it would match car physics time
---@field extendedPhysics boolean @True if extended car physics is active.
---@field isRacingCar boolean @True for racing cars (cars with class different from “road” or “street”).
---@field isRallyCar boolean @Car counts as rally car if it has a corresponding tag or “rally” in its name.
---@field isOpenWheeler boolean @Check is based on car tags.
---@field isEngineDiesel boolean @Check is based on car tags.
---@field isKunosCar boolean @True if car is standard, from Kunos.
---@field prefersImperialUnits boolean @True for cars from UK or USA.
---@field tractionControlModes integer @0 if TC is not present. Physics-only (see `ac.CarState.physicsAvailable`)
---@field absModes integer @0 if TC is not present. Physics-only (see `ac.CarState.physicsAvailable`)
---@field timestamp number @Time of last physics state record, in milliseconds (counting from the same point as ac.SimState.time)
---@field transform mat4x4 @Car physics transformation in world space (does not match body transformation! for it, use `bodyTransform`)
---@field pitTransform mat4x4 @Transformation of pit position.
---@field bodyTransform mat4x4 @Car visual transformation (the one applied to 3D model).
---@field worldToLocal mat4x4 @Inverse of car visual transformation.
---@field position vec3 @Car position in the world (corresponds to 0 coordinate in its model space).
---@field velocity vec3 @Car velocity in m/s.
---@field acceleration vec3 @G-forces, X for sideways relative to car, Z for forwards/backwards.
---@field angularVelocity vec3
---@field localAngularVelocity vec3
---@field localVelocity vec3
---@field up vec3 @Vector facing upwards (normalized).
---@field look vec3 @Vector facing forward (normalized).
---@field side vec3 @Vector facing sideways (normalized).
---@field driverEyesPosition vec3 @In-car coordinates for driver eyes position (can be changed by user).
---@field gas number @Throttle, from 0 to 1.
---@field brake number @Brake, from 0 to 1.
---@field clutch number @Clutch, from 0 to 1 (1 for pedal fully depressed).
---@field steer number @Angle of steering wheel in degrees.
---@field handbrake number @Handbrake, from 0 to 1.
---@field gear integer @Current gear, 0 for neutral, -1 for reverse. Does not go through 0 on sequential shifts
---@field engagedGear integer @Current gear, 0 for neutral, -1 for reverse. Goes through 0 on sequential shifts
---@field fuel number @Remaining fuel in liters.
---@field rpm number @Engine RPM.
---@field rpmLimiter number @RPM limiter threshold, if exists.
---@field speedKmh number @Current speed in km/h.
---@field turboBoost number @Turbo boost value, from 0 and upwards.
---@field drivetrainSpeed number @Speed delivered to wheels.
---@field waterTemperature number @Approximation of water temperature in °C done by original AC.
---@field minHeight number @Minimum allowed ride height in meters.
---@field restrictor number @Restrictor.
---@field ballast number @Ballast in kg.
---@field cgHeight number
---@field wheelsOutside integer @Number of wheels outside of allowed area.
---@field engineLifeLeft number @Engine life left (1000 for new engine, breaks at 0).
---@field damage number[] @Damage values from 0 to maximum collision speed in km/h for four different zones (fifth one is not really used). 5 items, starts with 0.
---@field gearboxDamage number @Gearbox damage (0 for new gearbox, 1 for non-functional).
---@field nodeIndex integer @Car index if 0 is nearest to camera, 1 is second nearest and so on.
---@field visibleIndex integer @Car index if 0 is nearest to camera and visible in main camera, 1 is second nearest visible and so on. Cars outside of main camera would have 255 here.
---@field activeLOD integer @0-based index of visible LOD.
---@field distanceToCamera number @Distance to camera in meters.
---@field splinePosition number @Position of car along the track, 0 for starting line, 1 for finishing line.
---@field driftPoints number @Drift points (calculated in any racing mode).
---@field driftInstantPoints number @Drift instant points (calculated in any racing mode).
---@field driftComboCounter integer @Drift combo counter (calculated in any racing mode).
---@field collisionDepth number @How deep is current collision, in meters (generally it’s better to use change of car speed to estimate collision intensity though, depth is much less predictable).
---@field collisionPosition vec3 @Coordinates of current collision in car space.
---@field collidedWith integer @0 for track, non-zero for cars.
---@field lapCutsCount integer @Number of lap cuts in current lap. Physics-only (see `ac.CarState.physicsAvailable`)
---@field lastLapCutsCount integer @Number of lap cuts in last lap.
---@field aiLevel number @AI level from 0 to 1 (or -1 if there is no AI).
---@field aiAggression number @AI aggression from 0 to 1 (or -1 if there is no AI).
---@field currentSplits integer[] @Time for different splits of current lap, in milliseconds. Items start with 0. To get number of elements, use `#state.currentSplits`.
---@field lastSplits integer[] @Time for different splits of last lap, in milliseconds. Items start with 0. To get number of elements, use `#state.lastSplits`.
---@field bestSplits integer[] @Best splits times (and not splits of best lap), in milliseconds. Items start with 0. To get number of elements, use `#state.bestSplits`.
---@field bestLapSplits integer[] @Splits times of best lap (not necessarily best split times in itself), in milliseconds. Items start with 0. To get number of elements, use `#state.bestLapSplits`.
---@field wheels ac.StateWheel[] @4 items, starts with 0.
---@field isActive boolean @True if car is currently active (changes to `false` for disconnected cars if server does not have them visible).
---@field isConnected boolean @True if car is currently connected (cars can be disconnected online), or if car is not a remote one.
---@field isRemote boolean @True if car is controlled by another player online.
---@field isAIControlled boolean @True if car is controlled by AI (or that autopilot thing).
---@field isLapValid boolean @True if current lap is valid. Physics-only (see `ac.CarState.physicsAvailable`)
---@field isLastLapValid boolean @True if last lap is valid.
---@field isCameraOnBoard boolean @True if camera is inside this car.
---@field isInPitlane boolean @True if car is in pits area.
---@field isInPit boolean @True if car is parked in its pit stop place.
---@field isRetired boolean
---@field isEngineLimiterOn boolean
---@field isGearGrinding boolean
---@field headlightsActive boolean
---@field brakeLightsActive boolean
---@field flashingLightsActive boolean
---@field hornActive boolean
---@field focused boolean
---@field focusedOnInterior boolean
---@field isHidingLabels boolean @If you’re drawing a map, don’t show cars with this flag on (those would be inactive cars or, for example, cars acting like traffic). Flag can change during the race
---@field isDriftBonusOn boolean @Drift bonus flag (calculated in any racing mode).
---@field isDriftValid boolean @Is drift valid (calculated in any racing mode).
---@field isRaceFinished boolean @Car has finished the race.
---@field hazardLights boolean
---@field turningLeftLights boolean
---@field turningRightLights boolean
---@field turningLeftOnly boolean
---@field turningRightOnly boolean
---@field lowBeams boolean
---@field extraA boolean
---@field extraB boolean
---@field extraC boolean
---@field extraD boolean
---@field extraE boolean
---@field extraF boolean
---@field kersCharging boolean
---@field turningLightsActivePhase boolean
---@field headlightsColor rgb
---@field kersCharge number
---@field kersInput number
---@field kersCurrentKJ number
---@field kersMaxKJ number
---@field kersLoad number
---@field distanceDrivenTotalKm number
---@field distanceDrivenSessionKm number
---@field poweredWheelsSpeed number
---@field batteryVoltage number
---@field oilPressure number
---@field oilTemperature number
---@field exhaustTemperature number
---@field wiperModes integer @Number of wiper modes, no less than 1 (wipers disabled state counts like a 0th mode, all cars would have that).
---@field wiperMode integer
---@field wiperSpeed number
---@field wiperProgress number
---@field bodyWetness number @How wet is car exterior, approximation from 0 to 1 (actual wetness is in 2D map).
---@field compass number @Angle of where car is heading, from 0 to 360 (0/360 for north, 90 for east, etc.)
---@field lapTimeMs integer @Time of current lap in milliseconds.
---@field bestLapTimeMs integer @Time of best lap of this session in milliseconds.
---@field previousLapTimeMs integer @Time of last lap in milliseconds.
---@field lapCount integer @Number of completed laps in this session, including spoiled laps.
---@field currentSector integer @0-based index of current track split.
---@field previousSectorTime integer @Time of previous split in milliseconds, or 0 if it’s a first split.
---@field racePosition integer @Position of a car in the race, 1 for first, 2 for second, etc.
---@field drivenInRace number @Distance driven in current race in meters (can be used for estimating race position, based on number of completed laps and current lap progress, in practice or qualify session resets each lap).
---@field estimatedLapTimeMs integer @Based on best lap and performance meter (delta of this lap time vs best lap time).
---@field performanceMeter number @Performance meter comparing this lap with best, seconds.
---@field performanceMeterSpeedDifferenceMs number @In AC performance app, there is that red/green bar, it shows this value.
---@field sessionLapCount integer
---@field compoundIndex integer @Index of currently selected tyre compounds.
---@field sessionID integer @Index of a car in an online race (differs from regular car index: sessionID is an index in entry list, but car.index of your car is always zero)
---@field physicsAvailable boolean @Cars in replays, or remote cars online do not have regular physics component running, so some data will be missing. Such fields are marked as physics-only in comments.
---@field speedLimiterInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field absInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field tractionControlInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field hasUserBrakeBias boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field hasEngineBrakeSettings boolean
---@field hasCockpitMGUHMode boolean
---@field hasCockpitERSDelivery boolean
---@field hasCockpitERSRecovery boolean
---@field drsPresent boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drsAvailable boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drsActive boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersPresent boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersHasButtonOverride boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersButtonPressed boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field mguhChargingBatteries boolean
---@field manualPitsSpeedLimiterEnabled boolean @Returns `true` if manual pits speed limiter is currently active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field userSpeedLimiterEnabled boolean @Returns `true` if custom physics speed limiter is currently active. Not the same as pit limiter (or manually operated speed limiter). Physics-only (see `ac.CarState.physicsAvailable`)
---@field mgukDelivery integer @Starts with 0.
---@field mgukDeliveryCount integer
---@field mgukRecovery integer @From 0 to 10 (for 100%).
---@field tractionControlMode integer @0 for disabled TC. Physics-only (see `ac.CarState.physicsAvailable`)
---@field absMode integer @0 for disabled ABS. Physics-only (see `ac.CarState.physicsAvailable`)
---@field engineBrakeSettingsCount integer
---@field currentEngineBrakeSetting integer
---@field fuelPerLap number @Uses original AC fuel estimation. Zero until value is available. Physics-only (see `ac.CarState.physicsAvailable`)
---@field differentialPreload number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field awdFrontShare number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field awdCenterLock number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drivetrainTorque number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drivetrainPower number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakeBias number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field speedLimiter number @Returns pit limiter speed in km/h (80 by default unless session specified different settings) or 0 if no limit is currently active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field turboBoosts number[] @Values per each turbo, up to 8 (if there are less turbos in a car, rest are zeroes). Physics-only (see `ac.CarState.physicsAvailable`) 8 items, starts with 0.
---@field turboWastegates number[] @Values per each turbo, up to 8 (if there are less turbos in a car, rest are zeroes). Physics-only (see `ac.CarState.physicsAvailable`) 8 items, starts with 0.
---@field tractionControl2 number
---@field fuelMap number @Current fuel map preset.
---@field steerTorque number
---@field ffbFinal number
---@field ffbPure number
---@field ffbMultiplier number @For 100% FFB multiplier, this value is set to 1.
---@field aeroLiftFront number @Aero lift coefficient in front.
---@field aeroLiftRear number @Aero lift coefficient in rear.
---@field aeroDrag number @Aero drag coefficient.
---@field caster number @Caster angle in degrees.
---@field rideHeight number[] @0 for front, 1 for rear. 2 items, starts with 0.
---@field p2pStatus integer
---@field p2pActivations integer
---@field altitude number @Altitude in meters above sea level.
---@field ambientOcclusion number @Ambient occlusion value computed from prebaked data from track’s VAO patch. 0 for car fully shadowed (in a tunnel), 1 for car outside.
---@field carCamerasCount integer @Number of F6 cameras.
---@field currentPenaltyType ac.PenaltyType @Current penalty type (set only for user car).
---@field currentPenaltyParameter integer @Parameter of current penalty (role depends on penalty type).

---@class ac.StateSession : ClassBase
---@field type ac.SessionType
---@field laps integer
---@field durationMinutes number
---@field isTimedRace boolean
---@field hasAdditionalLap boolean
---@field startTime number @Starting time in milliseconds (compares with `ac.SimState.time`)
---@field overtimeMs number
---@field forcedPosition integer
---@field leaderCompletedLaps integer
---@field isOver boolean

---@class ac.StateWheelPhysics : ClassBase
---@field brakeTorque number
---@field handbrakeTorque number
---@field electricTorque number
---@field feedbackTorque number
---@field angularInertia number
---@field shaftVelocity number
---@field shaftInertia number
---@field tyreCarcassTemperature number @Only available with custom physics tyres.

---@class ac.StateWingPhysics : ClassBase
---@field cd number @Drag coefficient (wing area is already taken into account here).
---@field cl number @Lift coefficient, negative for downforce (wing area is already taken into account here).
---@field aoa number @Angle of attack.
---@field angle number
---@field yawAngle number
---@field groundHeight number

---@class ac.StateCarPhysics : ClassBase
---@field isAvailable boolean
---@field gearRatio number
---@field finalRatio number
---@field awd2MaxTorque number
---@field awd2CurrentLockTorque number
---@field awd2Ramp number
---@field engineInertia number
---@field drivetrainInertia number
---@field drivetrainVelocity number
---@field clutchInertia number
---@field clutchState number
---@field wheels ac.StateWheelPhysics[] @4 items, starts with 0.
---@field scriptControllerInputs number[] @8 items, starts with 0.
---@field gearRatios number[] @Items start with 0. To get number of elements, use `#state.gearRatios`.
---@field wings ac.StateWingPhysics[] @Items start with 0. To get number of elements, use `#state.wings`.

---@class ac.StateSim : ClassBase
---@field windowWidth integer @Width of AC window in pixels (set in AC video settings). Might not be the same as UI screen size if scaling is used.
---@field windowHeight integer @Height of AC window in pixels (set in AC video settings). Might not be the same as UI screen size if scaling is used.
---@field msaaSamples integer @1 for MSAA disabled, 2 for MSAA 2x, 4 for 4x, 8 for 8x.
---@field worldDetailLevel integer @0 for very low, 5 for very high. Set in AC video settings
---@field isFullscreen boolean @A value from AC video settings, does not change live.
---@field isVSyncActive boolean @A value from AC video settings, does not change live.
---@field isPostProcessingActive boolean @True if YEBIS post-processing is active.
---@field isVRMode boolean @True if AC was launched with either Oculus or OpenVR mode (not necessarily successfully connected).
---@field isOculusMode boolean @True if AC was launched with Oculus mode (not necessarily successfully connected).
---@field isOpenVRMode boolean @True if AC was launched with OpenVR mode (not necessarily successfully connected).
---@field isTripleMode boolean @True if AC was launched in triple screen mode.
---@field isCustomVideoMode boolean @True if AC was launched with custom screen mode (fisheye, 360°, splitscreen).
---@field isVRConnected boolean @True if AC runs in either Oculus or OpenVR mode and initialization went successfully.
---@field staticReflections boolean @True if reflection cubemap does not update live and uses custom cubemap.kn5 instead of track model
---@field directMessagingAvailable boolean @True if it’s an online race and server supports TCP exchange of extra data between clients (allows to send online events more frequently).
---@field time number @Game time in milliseconds (counting from the start of the simulation).
---@field cameraPosition vec3
---@field cameraLook vec3 @Points forward (there was some confusion with older API).
---@field cameraUp vec3
---@field cameraSide vec3
---@field cameraFOV number @Returns current camera FOV in degrees. In VR, always returns 90°
---@field cameraClipNear number @Distance to near clipping plane in meters.
---@field cameraClipFar number @Distance to far clipping plane in meters.
---@field cameraDOFFactor number
---@field cameraDOFFocus number
---@field carsCount integer @No less than 1: at least a single car would always be present.
---@field closelyFocusedCar integer @0-based index, or -1 if there is no focused car (for example, with track camera or with free camera far from other cars).
---@field focusedCar integer @0-based index, or -1 if there is no focused car, unlike `.closelyFocusedCar` returns index of a car with track camera as well
---@field dt number @Delta time in seconds, 0 when paused, affected by replay slow motion and fast forwarding.
---@field isPaused boolean @If `true`, AC is currently paused.
---@field isInMainMenu boolean @If `true`, main menu is currently active.
---@field isLive boolean @If `true`, simulation is currently running (not paused and not in replay mode).
---@field isFreeCameraOutside boolean @Set to `true` if camera is either free or orbit (F7/F5) and not inside an interior.
---@field isReplayActive boolean
---@field isReplayOnlyMode boolean @True if AC is ran in replay mode, without any racing.
---@field isOnlineRace boolean @True if it’s an online race.
---@field isFocusedOnInterior boolean @True if camera is currently inside a car.
---@field controlsWithShifter boolean
---@field isVirtualMirrorActive boolean
---@field isVirtualMirrorForced boolean
---@field isWindowForeground boolean @True if AC window is currently active (focused and in front of other windows).
---@field isWeatherFXActive boolean
---@field isVAOPatchLoaded boolean
---@field ambientLightingMultiplier number
---@field ambientTemperature number
---@field roadTemperature number
---@field windSpeedKmh number
---@field windVelocityKmh vec2
---@field windDirectionDeg number
---@field rainIntensity number
---@field rainWetness number
---@field rainWater number
---@field timeTotalSeconds number @Number of seconds from midnight, not rounded.
---@field timeHours integer @Number of hours from midnight, rounded down.
---@field timeMinutes integer @Number of minutes in current hour, rounded down.
---@field timeSeconds integer @Number of seconds in current minute, rounded down.
---@field timeMultiplier number @Time multiplier set in race conditions.
---@field timestamp integer @Timestamp for in-game time (whole number seconds since 01/01/1970).
---@field dayOfYear integer @Returns number of current day in the year, from 1 to 366.
---@field raceFlagType ac.FlagType
---@field isSessionStarted boolean
---@field raceSessionType ac.SessionType
---@field timeToSessionStart number @Time to session start in milliseconds.
---@field sessionTimeLeft number @Remaining session time in milliseconds.
---@field currentSessionIndex integer @0-based index of current session (`.sessions` store more details about each session)
---@field sessionsCount integer
---@field trackLengthM number
---@field speedLimitKmh number
---@field fps number
---@field fpsCapped number
---@field physicsLate number
---@field cpuOccupancy integer
---@field cpuTime number
---@field firstPersonCameraFOV number @Current value for first person camera FOV in degrees. Global value, applying for all cars.
---@field cameraMode ac.CameraMode
---@field driveableCameraMode ac.DrivableCamera
---@field carCameraIndex integer @0-based index of currently active car camera (if `.cameraMode` is set to `ac.CameraMode.Car`). To find out how many ofd those cameras there are, use `ac.getCar(sim.focusedCar).carCamerasCount`
---@field trackCamerasSetsCount integer
---@field trackCamerasSet integer @0-based index of currently active track cameras set.
---@field audioMasterVolume number
---@field whiteReferencePoint number @Brightness of objects that would look white on-screen, such as UI in VR or driver name tags. You can also use it as a divider to adjust brightness of virtual mirrors (if you are not using postprocessing for virtual mirrors).
---@field specialEvent boolean @One of those archievment challenges is active.
---@field isTimedRace boolean
---@field penaltiesEnabled boolean
---@field fixedSetup boolean
---@field leaderLastLap boolean
---@field timeRaceEnded boolean
---@field timeRaceLastLap boolean
---@field timeRaceAdditionalLap boolean
---@field isAdmin boolean @Changes to true if user signs up as admin using that new chat app.
---@field pitsSpeedLimit number @Maximum speed allowed in pits in km/h. Regular value is 80, but servers might change it
---@field pitWindowStartTime number @If non-zero, start of mandatory pit time window (to get current time, use `.time`)
---@field pitWindowEndTime number @If non-zero, end of mandatory pit time window (to get current time, use `.time`)
---@field replayFrameMs number @Time of each replay frame in milliseconds.
---@field replayFrames integer @Number of recorded replay frames.
---@field replayCurrentFrame integer @0-based index of current replay frame.
---@field replayPlaybackRate number @0-based index of current replay frame.
---@field weatherType ac.WeatherType @Current weather type, set by WeatherFX controller or guessed from weather name.
---@field weatherSkyOcclusion number @Estimates sky occlusion based on current weather type.
---@field baseAltitude number @Altitude in meters above sea level associated with Y=0 level.
---@field connectedCars integer @Number of currently connected cars.
---@field randomSeed integer @Synced between clients online.
---@field lapSplits number[] @Normalized positions of track splits. Items start with 0. To get number of elements, use `#state.lapSplits`.
---@field handshakeServerTime number @Server time of the handshake, in milliseconds.
---@field currentServerTime number @Current server time (synced on all clients), in milliseconds. Resets to 0 when new race session (P/Q/R) starts.
---@field skyColor rgb @Sky color.
---@field horizonColor rgb @Horizon color.
---@field fogColor rgb @Fog color.
---@field lightColor rgb @Light (sun or moon) color.
---@field lightDirection vec3 @Light (sun or moon) direction.

---@class ac.StateUi : ClassBase
---@field windowSize vec2 @Size of AC UI window (affected by UI scale).
---@field mousePos vec2 @Mouse position within an AC UI window (affected by UI scale).
---@field dt number @Time between frames in seconds (not affected by pausing or replay speed modifier).
---@field mouseWheel number @Mouse wheel Vertical: 1 unit scrolls about 5 lines text.
---@field isMouseLeftKeyClicked boolean @Left mouse button was just pressed.
---@field isMouseMiddleKeyClicked boolean @Middle mouse button was just pressed.
---@field isMouseRightKeyClicked boolean @Right mouse button was just pressed.
---@field isMouseLeftKeyDoubleClicked boolean @Left mouse button was just double clicked.
---@field isMouseMiddleKeyDoubleClicked boolean @Middle mouse button was just double clicked.
---@field isMouseRightKeyDoubleClicked boolean @Right mouse button was just double clicked.
---@field isMouseLeftKeyDown boolean @Left mouse button is currently held.
---@field isMouseMiddleKeyDown boolean @Middle mouse button is currently held.
---@field isMouseRightKeyDown boolean @Right mouse button is currently held.
---@field ctrlDown boolean @Keyboard modifier pressed: Control.
---@field shiftDown boolean @Keyboard modifier pressed: Shift.
---@field altDown boolean @Keyboard modifier pressed: Alt.
---@field superDown boolean @Keyboard modifier pressed: Cmd/Super/Windows.
---@field wantCaptureMouse boolean @If your script is listening to mouse events, you might need to disable this functionality if this value is `true` — it means mouse is currently captured by some IMGUI element (for example, dragging happens).
---@field wantCaptureKeyboard boolean @If your script is listening to keyboard events, you might need to disable this functionality if this value is `true` — it means keyboard is currently captured by some IMGUI element (for example, user enters text in a text box).
---@field vrController boolean @If true, mouse is currenly controlled by VR controller, so its precision might be lower.
---@field framerate number @UI framerate estimation, in frame per second. Solely for convenience. Rolling average estimation based on IO.DeltaTime over 120 frames
---@field metricsRenderVertices integer @Vertices output during last call to Render().
---@field metricsRenderIndices integer @Indices output during last call to Render() = number of triangles * 3.
---@field metricsRenderWindows integer @Number of visible windows.
---@field metricsActiveWindows integer @Number of active windows.
---@field metricsRenderCommands integer @Number of draw calls.
---@field mouseDelta vec2 @Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.
---@field uiScale number @UI scale. Usually scripts shouldn’t worry about it, but just in case
---@field accentColor rgbm @Theme-defined accent color.

---@class ac.StateVrHand : ClassBase
---@field transform mat4x4
---@field triggerIndex number
---@field triggerHand number
---@field thumbstick vec2
---@field active boolean
---@field thumbUp boolean
---@field indexPointing boolean
---@field busy boolean @Set to true if hand is already going something, like grabbing an object. If so, don’t do any more grabbing (and don’t forget to call `ac.setVRHandBusy()` when you do)
---@field openVRButtons integer @OpenVR-specific buttons.
---@field openVRTouches integer @OpenVR-specific touches.
---@field openVRAxis vec2[] @OpenVR-specific touches. 5 items, starts with 0.

---@class ac.StateVr : ClassBase
---@field headTransform mat4x4
---@field headActive boolean
---@field oculusButtons integer @Oculus-specific buttons.
---@field oculusTouches integer @Oculus-specific touches.
---@field activeHand integer @Index of a hand that is actively moving, or -1.
---@field hands ac.StateVrHand[] @2 items, starts with 0.

---@class ac.StateDualsenseTouch : ClassBase
---@field delta vec2
---@field pos vec2
---@field id integer
---@field down boolean

---@class ac.StateDualsense : ClassBase
---@field accelerometer vec3
---@field gyroscope vec3
---@field battery number
---@field touches ac.StateDualsenseTouch[] @2 items, starts with 0.
---@field batteryCharging boolean
---@field batteryFullyCharged boolean
---@field headphonesConnected boolean
---@field connected boolean

---@class ac.StateDualsenseOutput : ClassBase
---@field lightBar rgbm
---@field microphoneLED integer @0 for disabled, 1 for enabled, 2 for flashing.
---@field playerLEDsBrightness integer @0 for max, 1 for medium, 2 for low.
---@field disableLEDs boolean
---@field playerLEDsFade boolean
---@field playerLEDs boolean[] @5 items, starts with 0.

--[[ common/common.lua ]]

---Disposable thing is something set which you can then un-set. Just call `ac.Disposable` returned
---from a function to cancel out whatever happened there. For example, unsubscribe from an event.
---@alias ac.Disposable fun()

---For better compatibility, acts like `ac.log()`.
function print(v) end

---Not doing anything anymore, kept for compatibility.
---@deprecated
function ac.skipSaneChecks() end

---Calls a function in a safe way, catching errors. If any errors were to occur, `catch` would be
---called with an error message as an argument. In either case (with and without error), if provided,
---`finally` will be called.
---@generic T
---@param fn fun(): T
---@param catch fun(err: string)
---@param finally fun()|nil
---@return T|nil
function try(fn, catch, finally) end

---Calls a function and then calls `dispose` function. Note: `dispose` function will be called even if
---there would be an error in `fn` function. But error would not be contained and will propagate.
---@generic T
---@param fn fun(): T
---@param dispose fun()
---@return T|nil
function using(fn, dispose) end

---Stores value in session shared Lua/Python storage. This is not a long-term storage, more of a way for
---different scripts to exchange data. Note: if you need to exchange a lot of data between Lua scripts,
---consider using ac.connect instead.
---
---Data string can contain zeroes.
---@param key string
---@param value string|number
function ac.store(key, value) end

---Reads value from session shared Lua/Python storage. This is not a long-term storage, more of a way for
---different scripts to exchange data. Note: if you need to exchange a lot of data between Lua scripts,
---consider using ac.connect instead.
---@param key string
---@return nil|string|number
function ac.load(key) end

---Adds a callback which might be called when script is unloading. Use it for some state reversion, but
---don’t rely on it too much. For example, if Assetto Corsa would crash or just close rapidly, it would not
---be called. It should be called when scripts reload though.
function ac.onRelease(callback) end

---For easy import of scripts from subdirectories. Provide it a name of a directory relative
---to main script folder and it would add that directory to paths it searches for.
---@param dir string
function package.add(dir) end

---Resolves relative path to a Lua module (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `require()` function.
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
function package.relative(path) end

---Resolves relative path to a file (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `io` functions (returns full path).
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
function io.relative(path) end

---Given an FFI struct, returns bytes with its content. Resulting string may contain zeroes.
---@param data any @FFI struct (type should be “cdata”).
---@return string|nil @If data is `nil`, returns `nil`.
function ac.structBytes(data) end

---Given an FFI struct and a string of data, fills struct with that data. Works only if size of struct matches size of data. Data string can contain zeroes.
---@generic T
---@param destination T @FFI struct (type should be “cdata”).
---@param data string @String with binary data.
---@return T
function ac.fillStructWithBytes(destination, data) end

--[[ common/ac_primitive_vec2.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec2(x, y)` directly, but the way LuaJIT works,
---that call only works with two numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec2): vec2
---@overload fun(tableOfTwo: number[]): vec2
---@overload fun(value: number): vec2
---@overload fun(value: string): vec2
---@param x? number
---@param y? number
---@return vec2
function vec2.new(x, y) end

---Checks if value is vec2 or not.
---@param p any
---@return boolean
function vec2.isvec2(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec2
function vec2.tmp() end

---Intersects two line segments, one going from `p1` to `p2` and another going from `p3` to `p4`. Returns intersection point or `nil` if there is no intersection.
---@return vec2?
function vec2.intersect(p1, p2, p3, p4) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@return vec2
function vec2(x, y) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec2
---@field x number
---@field y number
local vec2 = nil

---Makes a copy of a vector.
---@return vec2
function vec2:clone() end

---Unpacks vec2 into rgb and number.
---@return rgb, number
function vec2:unpack() end

---Turns vec2 into a table with two values.
---@return number[]
function vec2:table() end

---Returns reference to vec2 class.
function vec2:type() end

---@param x vec2|number
---@param y number?
---@return vec2 @Returns itself.
function vec2:set(x, y) end

---@param vec vec2
---@param scale number
---@return vec2 @Returns itself.
function vec2:setScaled(vec, scale) end

---@param value1 vec2
---@param value2 vec2
---@param mix number
---@return vec2 @Returns itself.
function vec2:setLerp(value1, value2, mix) end

---Copies its values to a different vector.
---@param out vec2
---@return vec2 @Returns itself.
function vec2:copyTo(out) end

---@param valueToAdd vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:add(valueToAdd, out) end

---@param valueToAdd vec2
---@param scale number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:div(valueToDivideBy, out) end

---@param exponent vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:pow(exponent, out) end

---@param multiplier number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:scale(multiplier, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:min(otherValue, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:max(otherValue, out) end

---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:saturate(out) end

---@param min vec2
---@param max vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:clamp(min, max, out) end

---@return number
function vec2:length() end

---@return number
function vec2:lengthSquared() end

---@param otherVector vec2
---@return number
function vec2:distance(otherVector) end

---@param otherVector vec2
---@return number
function vec2:distanceSquared(otherVector) end

---@param otherVector vec2
---@param distanceThreshold number
---@return boolean
function vec2:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec2
---@return number @Radians.
function vec2:angle(otherVector) end

---@param otherVector vec2
---@return number
function vec2:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec2
---@param mix number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:project(otherVector, out) end

--[[ common/ac_primitive_vec3.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec3(x, y, z)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec3): vec3
---@overload fun(tableOfThree: number[]): vec3
---@overload fun(value: number): vec3
---@overload fun(value: string): vec3
---@param x number?
---@param y number?
---@param z number?
---@return vec3
function vec3.new(x, y, z) end

---Checks if value is vec3 or not.
---@param p any
---@return boolean
function vec3.isvec3(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec3
function vec3.tmp() end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@return vec3
function vec3(x, y, z) end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec3
---@field x number
---@field y number
---@field z number
local vec3 = nil

---Makes a copy of a vector.
---@return vec3
function vec3:clone() end

---Unpacks vec3 into rgb and number.
---@return rgb, number
function vec3:unpack() end

---Turns vec3 into a table with three values.
---@return number[]
function vec3:table() end

---Returns reference to vec3 class.
function vec3:type() end

---@param x vec3|number
---@param y number?
---@param z number?
---@return vec3 @Returns itself.
function vec3:set(x, y, z) end

---@param vec vec3
---@param scale number
---@return vec3 @Returns itself.
function vec3:setScaled(vec, scale) end

---@param value1 vec3
---@param value2 vec3
---@param mix number
---@return vec3 @Returns itself.
function vec3:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec3
---@param value2 vec3
---@return vec3 @Returns itself.
function vec3:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec3
---@return vec3 @Returns itself.
function vec3:copyTo(out) end

---@param valueToAdd vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:add(valueToAdd, out) end

---@param valueToAdd vec3
---@param scale number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:div(valueToDivideBy, out) end

---@param exponent vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:pow(exponent, out) end

---@param multiplier number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:scale(multiplier, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:min(otherValue, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:max(otherValue, out) end

---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:saturate(out) end

---@param min vec3
---@param max vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:clamp(min, max, out) end

---@return number
function vec3:length() end

---@return number
function vec3:lengthSquared() end

---@param otherVector vec3
---@return number
function vec3:distance(otherVector) end

---@param otherVector vec3
---@return number
function vec3:distanceSquared(otherVector) end

---@param otherVector vec3
---@param distanceThreshold number
---@return boolean
function vec3:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec3
---@return number @Radians.
function vec3:angle(otherVector) end

---@param otherVector vec3
---@return number
function vec3:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:normalize(out) end

---Rewrites own values with values of cross product of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:cross(otherVector, out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param mix number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:project(otherVector, out) end

---Rewrites own values with values of itself rotated with quaternion (unless different `out` is provided).
---@param quaternion quat
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:rotate(quaternion, out) end

---Returns distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLine(a, b) end

---Returns squared distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLineSquared(a, b) end

--[[ common/ac_primitive_vec4.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec4(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec4): vec4
---@overload fun(tableOfFour: number[]): vec4
---@overload fun(value: number): vec4
---@overload fun(value: string): vec4
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return vec4
function vec4.new(x, y, z, w) end

---Checks if value is vec4 or not.
---@param p any
---@return boolean
function vec4.isvec4(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec4
function vec4.tmp() end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return vec4
function vec4(x, y, z, w) end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec4
---@field x number
---@field y number
---@field z number
---@field w number
local vec4 = nil

---Makes a copy of a vector.
---@return vec4
function vec4:clone() end

---Unpacks vec4 into rgb and number.
---@return rgb, number
function vec4:unpack() end

---Turns vec4 into a table with four values.
---@return number[]
function vec4:table() end

---Returns reference to vec4 class.
function vec4:type() end

---@param x vec4|number
---@param y number?
---@param z number?
---@param w number?
---@return vec4 @Returns itself.
function vec4:set(x, y, z, w) end

---@param vec vec4
---@param scale number
---@return vec4 @Returns itself.
function vec4:setScaled(vec, scale) end

---@param value1 vec4
---@param value2 vec4
---@param mix number
---@return vec4 @Returns itself.
function vec4:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec4
---@param value2 vec4
---@return vec4 @Returns itself.
function vec4:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec4
---@return vec4 @Returns itself.
function vec4:copyTo(out) end

---@param valueToAdd vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:add(valueToAdd, out) end

---@param valueToAdd vec4
---@param scale number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:div(valueToDivideBy, out) end

---@param exponent vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:pow(exponent, out) end

---@param multiplier number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:scale(multiplier, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:min(otherValue, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:max(otherValue, out) end

---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:saturate(out) end

---@param min vec4
---@param max vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:clamp(min, max, out) end

---@return number
function vec4:length() end

---@return number
function vec4:lengthSquared() end

---@param otherVector vec4
---@return number
function vec4:distance(otherVector) end

---@param otherVector vec4
---@return number
function vec4:distanceSquared(otherVector) end

---@param otherVector vec4
---@param distanceThreshold number
---@return boolean
function vec4:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec4
---@return number @Radians.
function vec4:angle(otherVector) end

---@param otherVector vec4
---@return number
function vec4:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec4
---@param mix number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:project(otherVector, out) end

--[[ common/ac_primitive_rgb.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgb(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgb): rgb
---@overload fun(color: rgbm): rgb
---@overload fun(color: hsv): rgb
---@overload fun(color: vec4): rgb
---@overload fun(color: vec3): rgb
---@overload fun(tableOfThree: number[]): rgb
---@overload fun(color: number): rgb
---@overload fun(value: string): rgb
---@param r number?
---@param g number?
---@param b number?
---@return rgb
function rgb.new(r, g, b, m) end

---Checks if value is rgb or not.
---@param p any
---@return boolean
function rgb.isrgb(p) end

---Temporary color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgb
function rgb.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255
---@param g number @From 0 to 255
---@param b number @From 0 to 255
---@return rgb
function rgb.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgb.colors = {
  transparent = rgb(0, 0, 0),
  black = rgb(0, 0, 0),
  silver = rgb(0.75, 0.75, 0.75),
  gray = rgb(0.5, 0.5, 0.5),
  white = rgb(1, 1, 1),
  maroon = rgb(0.5, 0, 0),
  red = rgb(1, 0, 0),
  purple = rgb(0.5, 0, 0.5),
  fuchsia = rgb(1, 0, 1),
  green = rgb(0, 0.5, 0),
  lime = rgb(0, 1, 0),
  olive = rgb(0.5, 0.5, 0),
  yellow = rgb(1, 1, 0),
  orange = rgb(1, 0.5, 0),
  navy = rgb(0, 0, 0.5),
  blue = rgb(0, 0, 1),
  teal = rgb(0, 0.5, 0.5),
  cyan = rgb(0, 0.5, 1),
  aqua = rgb(0, 1, 1),
}

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@return rgb
function rgb(r, g, b) end

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@class rgb
---@field r number
---@field g number
---@field b number
local rgb = nil

---Makes a copy of a vector.
---@return rgb
function rgb:clone() end

---Unpacks rgb into three numbers.
---@return rgb, number
function rgb:unpack() end

---Turns rgb into a table with three numbers.
---@return number[]
function rgb:table() end

---Returns reference to rgb class.
function rgb:type() end

---@param r rgb|number
---@param g number?
---@param b number?
---@return rgb @Returns itself.
function rgb:set(r, g, b) end

---@param x rgb
---@param mult number
---@return rgb @Returns itself.
function rgb:setScaled(x, mult) end

---@param value1 rgb
---@param value2 rgb
---@param mix number
---@return rgb @Returns itself.
function rgb:setLerp(value1, value2, mix) end

---@param valueToAdd rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:add(valueToAdd, out) end

---@param valueToAdd rgb
---@param scale number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:div(valueToDivideBy, out) end

---@param exponent rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:pow(exponent, out) end

---@param multiplier number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:scale(multiplier, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:min(otherValue, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:max(otherValue, out) end

---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:saturate(out) end

---@param min rgb
---@param max rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:clamp(min, max, out) end

---Adjusts saturation using a very simple formula.
---@param saturation number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:adjustSaturation(saturation, out) end

---Makes sure brightest value does not exceed 1.
---@return rgb @Returns itself.
function rgb:normalize() end

---Returns brightest value (aka V in HSV).
---@return number
function rgb:value() end

---Returns hue.
---@return number
function rgb:hue() end

---Returns saturation.
---@return number
function rgb:saturation() end

---Returns luminance value.
---@return number
function rgb:luminance() end

---Returns rgbm.
---@param mult number? @Default value: 1.
---@return rgbm
function rgb:rgbm(mult) end

---Returns HSV color of rgb*mult.
---@return hsv
function rgb:hsv() end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgb:vec3() end

--[[ common/ac_primitive_hsv.lua ]]

---Creates new instance. It’s usually faster to create a new item with `hsv(h, s, v)`.
---@param h number?
---@param s number?
---@param v number?
---@return hsv
function hsv.new(h, s, v) end

---Checks if value is hsv or not.
---@param p any
---@return boolean
function hsv.ishsv(p) end

---Temporary HSV color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return hsv
function hsv.tmp() end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@param h number? 
---@param s number? 
---@param v number? 
---@return hsv
function hsv(h, s, v) end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@class hsv
---@field h number
---@field s number
---@field v number
local hsv = nil

---Makes a copy of a vector.
---@return hsv
function hsv:clone() end

---Unpacks hsv into three numbers.
---@return rgb, number
function hsv:unpack() end

---Turns hsv into a table with three numbers.
---@return number[]
function hsv:table() end

---Returns reference to hsv class.
function hsv:type() end

---@param h number
---@param s number
---@param v number
---@return hsv @Returns itself.
function hsv:set(h, s, v) end

---Returns RGB color.
---@return rgb
function hsv:rgb() end

--[[ common/ac_primitive_rgbm.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgbm(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgbm): rgbm
---@overload fun(color: rgb): rgbm
---@overload fun(color: hsv): rgbm
---@overload fun(color: vec4): rgbm
---@overload fun(color: vec3): rgbm
---@overload fun(tableOfFour: number[]): rgbm
---@overload fun(hexColor: string): rgbm
---@overload fun(colorAlpha: number): rgbm
---@overload fun(color: number, alpha: number): rgbm
---@param r number?
---@param g number?
---@param b number?
---@param m number? @Default value: 1.
---@return rgbm
function rgbm.new(r, g, b, m) end

---Checks if value is rgbm or not.
---@param p any
---@return boolean
function rgbm.isrgbm(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgbm
function rgbm.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255.
---@param g number @From 0 to 255.
---@param b number @From 0 to 255.
---@param a number? @From 0 to 1. Default value: 1.
---@return rgbm
function rgbm.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgbm.colors = {
  transparent = rgbm(0, 0, 0, 0),
  black = rgbm(0, 0, 0, 1),
  silver = rgbm(0.75, 0.75, 0.75, 1),
  gray = rgbm(0.5, 0.5, 0.5, 1),
  white = rgbm(1, 1, 1, 1),
  maroon = rgbm(0.5, 0, 0, 1),
  red = rgbm(1, 0, 0, 1),
  purple = rgbm(0.5, 0, 0.5, 1),
  fuchsia = rgbm(1, 0, 1, 1),
  green = rgbm(0, 0.5, 0, 1),
  lime = rgbm(0, 1, 0, 1),
  olive = rgbm(0.5, 0.5, 0, 1),
  yellow = rgbm(1, 1, 0, 1),
  orange = rgbm(1, 0.5, 0, 1),
  navy = rgbm(0, 0, 0.5, 1),
  blue = rgbm(0, 0, 1, 1),
  teal = rgbm(0, 0.5, 0.5, 1),
  cyan = rgbm(0, 0.5, 1, 1),
  aqua = rgbm(0, 1, 1, 1),
}

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@param mult number? 
---@return rgbm
function rgbm(r, g, b, mult) end

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@class rgbm
---@field r number
---@field g number
---@field b number
---@field rgb rgb
---@field mult number
local rgbm = nil

---Makes a copy of a vector.
---@return rgbm
function rgbm:clone() end

---Unpacks rgbm into rgb and number.
---@return rgb, number
function rgbm:unpack() end

---Turns rgbm into a table with four values.
---@return number[]
function rgbm:table() end

---Returns reference to rgbm class.
function rgbm:type() end

---@param rgb rgbm|rgb
---@param mult number?
---@return rgbm @Returns itself.
function rgbm:set(rgb, mult) end

---@param value1 rgbm
---@param value2 rgbm
---@param mix number
---@return rgbm @Returns itself.
function rgbm:setLerp(value1, value2, mix) end

---@param valueToAdd rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:add(valueToAdd, out) end

---@param valueToAdd rgbm
---@param scale number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:div(valueToDivideBy, out) end

---@param exponent rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:pow(exponent, out) end

---@param multiplier number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:scale(multiplier, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:min(otherValue, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:max(otherValue, out) end

---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:saturate(out) end

---@param min rgbm
---@param max rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:clamp(min, max, out) end

---Makes sure brightest value does not exceed 1.
---@return rgbm @Returns itself.
function rgbm:normalize() end

---Returns brightest value.
---@return number
function rgbm:value() end

---Returns luminance value.
---@return number
function rgbm:luminance() end

---Returns color (rgb*mult).
---@return rgb
function rgbm:color() end

---Returns HSV color of rgb*mult.
---@return hsv
function rgbm:hsv() end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgbm:vec3() end

---Returns vec4, where X, Y and Z are RGB values and W is mult.
---@return vec4
function rgbm:vec4() end

--[[ common/ac_primitive_quat.lua ]]

---Creates new quaternion. It’s usually faster to create a new item with `quat(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: quat): quat
---@overload fun(tableOfFour: number[]): quat
---@overload fun(value: number): quat
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return quat
function quat.new(x, y, z, w) end

---Checks if value is quat or not.
---@param p any
---@return boolean
function quat.isquat(p) end

---Creates a new quaternion.
---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromAngleAxis(angle, x, y, z) end

---Creates a new quaternion.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromDirection(x, y, z) end

---Creates a new quaternion.
---@param u quat
---@param v quat
---@return quat
function quat.between(u, v) end

---Temporary quaternion. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return quat
function quat.tmp() end

---Quaternion. All operators are overloaded.
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return quat
function quat(x, y, z, w) end

---Quaternion. All operators are overloaded.
---@class quat
---@field x number
---@field y number
---@field z number
---@field w number
local quat = nil

---Makes a copy of a quaternion.
---@return quat
function quat:clone() end

---Unpacks quat into rgb and number.
---@return rgb, number
function quat:unpack() end

---Turns quat into a table with four values.
---@return number[]
function quat:table() end

---Returns reference to quat class.
function quat:type() end

---@param x quat|number
---@param y number?
---@param z number?
---@param w number?
---@return quat @Returns itself.
function quat:set(x, y, z, w) end

---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setAngleAxis(angle, x, y, z) end

---@return number @Angle in radians.
---@return number @Axis, X.
---@return number @Axis, Y.
---@return number @Axis, Z.
function quat:getAngleAxis() end

---@param u quat
---@param v quat
---@return quat @Returns itself.
function quat:setBetween(u, v) end

---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setDirection(x, y, z) end

---@param valueToAdd quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:add(valueToAdd, out) end

---@param valueToSubtract quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:sub(valueToSubtract, out) end

---@param valueToMultiplyBy quat
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:mul(valueToMultiplyBy, out) end

---@param multiplier number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:scale(multiplier, out) end

---@return number
function quat:length() end

---Normalizes itself (unless different `out` is provided).
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:normalize(out) end

---Rewrites own values with values of lerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:lerp(otherVector, mix, out) end

---Rewrites own values with values of slerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:slerp(otherVector, mix, out) end

--[[ common/ac_smoothing.lua ]]

---Call it once every frame at the beginning, it would affect all instances of `smoothing`.
---@param dt number @Time passed since last frame, in seconds.
function smoothing.setDT(dt) end

---Strange thing which is only kept for backwards compatibility. Holds a value, numerical or a vector, and
---updates it every frame slowly moving it towards target value. For new projects, I would recommend to use
---something else.
---
---It doesn’t even use lag parameter, but instead some strange “smooth” thing…
---@param initialValue number|vec2|vec3|vec4 
---@param smoothingIntensity number? "Default value: 100."
---@return smoothing
function smoothing(initialValue, smoothingIntensity) end

---Strange thing which is only kept for backwards compatibility. Holds a value, numerical or a vector, and
---updates it every frame slowly moving it towards target value. For new projects, I would recommend to use
---something else.
---
---It doesn’t even use lag parameter, but instead some strange “smooth” thing…
---@class smoothing
---@field val number|vec2|vec3|vec4
---@field lastValue number|vec2|vec3|vec4
---@field smooth number
local smoothing = nil

---Updates value, moving it closer to `newValue`.
---@param newValue number|vec2|vec3|vec4 @Target value to move to.
function smoothing:update(newValue) end

---Updates value, moving it closer to `newValue`, but only if `newValue` is different from the one used in
---`:updateIfNew()` last time. And for vectors it compares not by value, but by reference. Makes me wonder what was I
---thinking about.
---@param newValue number|vec2|vec3|vec4 @Target value to move to.
function smoothing:updateIfNew(newValue) end

--[[ common/ac_matrices.lua ]]

---Creates a new neutral matrix.
---@return mat3x3
function mat3x3.identity() end

---@param row1 vec3 
---@param row2 vec3 
---@param row3 vec3 
---@return mat3x3
function mat3x3(row1, row2, row3) end

---@class mat3x3
---@field row1 vec3
---@field row2 vec3
---@field row3 vec3
local mat3x3 = nil

---@param value mat3x3
---@return mat3x3
function mat3x3:set(value) end

---@return mat3x3
function mat3x3:clone() end

---Creates a new neutral matrix.
---@return mat4x4
function mat4x4.identity() end

---Creates a translation matrix.
---@param offset vec3
---@return mat4x4
function mat4x4.translation(offset) end

---Creates a rotation matrix.
---@param angle number @Angle in radians.
---@param axis vec3
---@return mat4x4
function mat4x4.rotation(angle, axis) end

---Creates a scaling matrix.
---@param scale vec3
---@return mat4x4
function mat4x4.scaling(scale) end

---@param row1 vec4 
---@param row2 vec4 
---@param row3 vec4 
---@param row4 vec4 
---@return mat4x4
function mat4x4(row1, row2, row3, row4) end

---@class mat4x4
---@field row1 vec4
---@field row2 vec4
---@field row3 vec4
---@field row4 vec4
---@field position vec3
---@field look vec3
---@field side vec3
---@field up vec3
local mat4x4 = nil

---@param value mat4x4
---@return mat4x4
function mat4x4:set(value) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformVectorTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformVector(vec) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformPointTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformPoint(vec) end

---@return mat4x4
function mat4x4:clone() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:inverse() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:inverseSelf() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:transpose() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:transposeSelf() end

---Note: unlike vector’s `:mul()`, this one creates a new matrix!
---@param other mat4x4
---@return mat4x4
function mat4x4:mul(other) end

---Modifies current matrix.
---@param other mat4x4
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:mulSelf(other) end

--[[ common/math.lua ]]

---Takes value with even 0…1 distribution and remaps it to recreate a distribution
---similar to Gaussian’s one (with k≈0.52, a default value). Lower to make bell more
---compact, use a value above 1 to get some sort of inverse distibution.
---@param x number @Value to adjust.
---@param k number @Bell curvature parameter.
---@return number
function math.gaussianAdjustment(x, k) end

---Builds a list of points arranged in a square with poisson distribution.
---@param size integer @Number of points.
---@param tileMode boolean? @If set to `true`, resulting points would be tilable without breaking poisson distribution.
---@return vec2[]
function math.poissonSamplerSquare(size, tileMode) end

---Builds a list of points arranged in a circle with poisson distribution.
---@param size integer @Number of points.
---@return vec2[]
function math.poissonSamplerCircle(size) end

---Generates a random number in [0, INT32_MAX) range. Can be a good argument for `math.randomseed()`.
---@return integer
function math.randomKey() end

---Generates random number based on a seed.
---@param seed integer|boolean|string @Seed.
---@return number @Random number from 0 to 1.
function math.seededRandom(seed) end

---Rounds number, leaves certain number of decimals.
---@param number number
---@param decimals number? @Default value: 0 (rounding to a whole number).
function math.round(number, decimals) end

---Clamps a number value between `min` and `max`.
---@param value number
---@param min number
---@param max number
---@return number
function math.clampN(value, min, max) end

---Clamps a number value between 0 and 1.
---@param value number
---@return number
function math.saturateN(value) end

---Clamps a copy of a vector between `min` and `max`. To avoid making copies, use `vec:clamp(min, max)`.
---@generic T
---@param value T
---@param min any
---@param max any
---@return T
function math.clampV(value, min, max) end

---Clamps a copy of a vector between 0 and 1. To avoid making copies, use `vec:saturate()`.
---@generic T
---@param value T
---@return T
function math.saturateV(value) end

---Clamps value between `min` and `max`, returning `min` if `x` is below `min` or `max` if `x` is above `max`. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@param min any
---@param max any
---@return T
function math.clamp(x, min, max) end

---Clamps value between 0 and 1, returning 0 if `x` is below 0 or 1 if `x` is above 1. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@return T
function math.saturate(x) end

---Returns a sing of a value, or 0 if value is 0.
---@param x number
---@return integer
function math.sign(x) end

---Linear interpolation between `x` and `y` using `mix` (x * (1 - mix) + y * mix).
---@param x number
---@param y number
---@param mix number
---@return number
function math.lerp(x, y, mix) end

---Returns 0 if value is less than v0, returns 1 if it’s more than v1, linear interpolation in-between.
---@param value number
---@param min number
---@param max number
---@return number
function math.lerpInvSat(value, min, max) end

---Smoothstep operation. More about it in [wiki](https://en.wikipedia.org/wiki/Smoothstep).
---@param x number
---@return number
function math.smoothstep(x) end

---Like a smoothstep operation, but even smoother.
---@param x number
---@return number
function math.smootherstep(x) end

---Creates a copy of a vector and normalizes it. Consider avoiding making a copy with `vec:normalize()`.
---@generic T
---@param x T
---@return T
function math.normalize(x) end

---Creates a copy of a vector and runs a cross product on it. Consider avoiding making a copy with `vec:cross(otherVec)`.
---@param x vec3
---@return vec3
function math.cross(x, y) end

---Calculates dot product of two vectors.
---@param x vec2|vec3|vec4
---@return number
function math.dot(x, y) end

---Calculates angle between vectors in radians.
---@param x vec2|vec3|vec4
---@return number @Radians.
function math.angle(x, y) end

---Calculates distance between vectors.
---@param x vec2|vec3|vec4
---@return number
function math.distance(x, y) end

---Calculates squared distance between vectors (slightly faster without taking a square root).
---@param x vec2|vec3|vec4
---@return number
function math.distanceSquared(x, y) end

---Creates a copy of a vector and projects it onto a different vector. Consider avoiding making a copy with `vec:project(otherVec)`.
---@generic T
---@param x T
---@return T
function math.project(x, y) end

---Checks if value is NaN.
---@param x number
---@return boolean
function math.isNaN(x) end

---@type number
math.NaN = 0/0

---@param lag number
---@param dt number
---@return number
function math.lagMult(lag, dt) end

---@param value number
---@param target number
---@param lag number
---@param dt number
---@return number
function math.applyLag(value, target, lag, dt) end

--[[ common/string.lua ]]

---Splits string into an array using separator.
---@param self string @String to split.
---@param separator string? @Separator. If empty, string will be split into individual characters. Default value: ` `.
---@param limit integer? @Limit for pieces of string. Once reached, remaining string is put as a list piece.
---@param trimResult boolean? @Set to `true` to trim found strings. Default value: `false`.
---@param skipEmpty boolean? @Set to `false` to keep empty strings. Default value: `true` (for compatibility reasons).
---@param splitByAnyChar boolean? @Set to `true` to split not by a string `separator`, but by any characters in `separator`.
---@return string[]
function string.split(self, separator, limit, trimResult, skipEmpty, splitByAnyChar) end

---Splits string into a bunch of numbers (not in an array). Any symbol that isn’t a valid part of number is considered to be a delimiter. Does not create an array
---to keep things faster. To make it into an array, simply wrap the call in `{}`.
---@param self string @String to split.
---@param limit integer? @Limit for amount of numbers. Once reached, remaining part is ignored.
---@return ... @Numbers
function string.numbers(self, limit) end

---Checks if the beginning of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the beginning of.
---@param another string @String to match.
---@param offset integer? @Optional offset for the matching beginning. Default value: `0`.
---@return boolean
function string.startsWith(self, another, offset) end

---Checks if the end of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the end of.
---@param another string @String to match.
---@param offset integer? @Optional offset for the matching end. Default value: `0`.
---@return boolean
function string.endsWith(self, another, offset) end

---Compares string alphanumerically.
---@param self string @First string.
---@param another string @Second string.
---@return integer @Returns positive number if first string is larger than second one, or 0 if strings are equal.
function string.alphanumCompare(self, another) end

---Trims string at beginning and end.
---@param self string @String to trim.
---@param characters string? @Characters to remove. Default value: `'\n\r\t '`.
---@param direction integer? @Direction to trim, 0 for trimming both ends, -1 for trimming beginning only, 1 for trimming the end. Default value: `0`.
---@return string
function string.trim(self, characters, direction) end

---Repeats string a given number of times (`repeat` is a reserved keyword, so here we are).
---@param self string @String to trim.
---@param count integer @Number of times to repeat the string.
---@return string
function string.multiply(self, count) end

---Pads string with symbols from `pad` until it reaches the desired length.
---@param self string @String to trim.
---@param targetLength integer @Desired string length. If shorter than current length, string will be trimmed from the end.
---@param pad string? @String to pad with. If empty, no padding will be performed. If has more than one symbol, will be repeated to fill the space. Default value: ` ` (space).
---@param direction integer? @Direction to pad to, 1 for padding at the end, -1 for padding at the start, 0 for padding from both ends centering string. Default value: `1`.
---@return string
function string.pad(self, targetLength, pad, direction) end

---Similar to `string.find()`: looks for the first match of `pattern` and returns indices, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return integer? @1-based index of where the match occured, or `nil` if no match has been found.
---@return integer @1-based index of the ending of found pattern, or `nil` if no match has been found.
---@return ... @Captured elements, if there are any capture groups in the pattern.
---@nodiscard
function string.regfind(self, pattern, init, ignoreCase) end

---Similar to `string.match()`: looks for the first match of `pattern` and returns matches, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @Captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.regmatch(self, pattern, init, ignoreCase) end

---Similar to `string.gmatch()`: iterates over matches of `pattern`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return fun():string, ... @Iterator with captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.reggmatch(self, pattern, ignoreCase) end

---Similar to `string.gsub()`: replaces all entries of `pattern` with `repl`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param repl    string|table|function @Replacement value. Used in the same way as with `string.gsub()`, could be a table or a function.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @String with found entries replaced.
---@nodiscard
function string.reggsub(self, pattern, repl, ignoreCase) end

--[[ common/table.lua ]]

---Merges tables into one big table. Tables can be arrays or dictionaries, if it’s a dictionary same keys from subsequent tables will overwrite previously set keys.
---@generic T
---@param table T[]
---@vararg table
---@return T[]
function table.chain(table, ...) end

--[[ common/table.lua ]]

---Checks if table is an array or not. Arrays are tables that only have consequtive numeric keys.
---@param t table|any[]
---@return boolean
function table.isArray(t) end

---Creates a new table with preallocated space for given amount of elements.
---@param arrayElements integer @How many elements the table will have as a sequence.
---@param mapElements integer @How many other elements the table will have.
---@return table
function table.new(arrayElements, mapElements) end

---Cleares table without deallocating space using a fast LuaJIT call. Can work
---with both array and non-array tables.
---@param t table
function table.clear(t) end

---Returns the total number of elements in a given Lua table (i.e. from both the array and hash parts combined).
---@param t table
function table.nkeys(t) end

---Clones table using a fast LuaJIT call.
---@param t table
function table.clone(t) end

---Removes first item by value, returns true if any item was removed. Can work
---with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
function table.removeItem(t, item) end

---Returns an element from table with a given key. If there is no such element, calls callback
---and uses its return value to add a new element and return that. Can work
---with both array and non-array tables.
---@generic T
---@generic TCallbackData
---@param t table<any, T>
---@param key any
---@param callback fun(callbackData: TCallbackData): T
---@param callbackData TCallbackData?
---@return T
function table.getOrCreate(t, key, callback, callbackData) end

---Returns true if table contains an item. Can work with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
function table.contains(t, item) end

---Returns a random item from a table. Optional callback works like a filter. Can work
---with both array and non-array tables. Alternatively, optional callback can provide a number
---for a weight of an item.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param filteringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): boolean
---@param filteringCallbackData TCallbackData?
---@param randomDevice nil|fun(): number @Optional callback for generating random numbers. Needs to return a value between 0 and 1. If not set, default `math.random` is used.
---@return T
function table.random(t, filteringCallback, filteringCallbackData, randomDevice) end

---Returns a key of a given element, or `nil` if there is no such element in a table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@param t table<TKey, T>
---@param item T
---@return TKey|nil
function table.indexOf(t, item) end

---Joins elements of a table to a string, works with both arrays and non-array tables. Optinal
---toStringCallback parameter can be used for a custom item serialization. All parameters but
---`t` (for actual table) are optional and can be skipped.
---
---Note: it wouldn’t work as fast as `table.concat`, but it would call a `tostring()` (or custom
---serializer callback) for each element.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param itemsJoin string? @Default value: ','.
---@param keyValueJoin string? @Default value: '='.
---@param toStringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): string
---@param toStringCallbackData TCallbackData?
---@overload fun(t: table, itemsJoin: string, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@overload fun(t: table, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@return TKey|nil
function table.join(t, itemsJoin, keyValueJoin, toStringCallback, toStringCallbackData) end

---Slices array, basically acts like slicing thing in Python.
---@generic T
---@param t T[]
---@param from integer @Starting index.
---@param to integer? @Ending index.
---@param step integer? @Step.
---@return T[]
function table.slice(t, from, to, step) end

---Flips table from back to front, requires an array.
---@generic T
---@param t T[]
---@return T[]
function table.reverse(t) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TReturnKey
---@generic TReturnValue
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): TReturnValue, TReturnKey|nil @Mapping callback.
---@param callbackData TCallbackData?
---@return table<TReturnKey, TReturnValue>
function table.map(t, callback, callbackData) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TData
---@param t table<TKey, T>
---@param startingValue TData
---@param callback fun(data: TData, item: T, index: TKey, callbackData: TCallbackData): TData @Reduction callback.
---@param callbackData TCallbackData?
---@return TData
function table.reduce(t, startingValue, callback, callbackData) end

---Creates a new table from all elements for which filtering callback returns true. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): any @Filtering callback.
---@param callbackData TCallbackData?
---@return table<TKey, T>
function table.filter(t, callback, callbackData) end

---Returns true if callback returns non-false value for every element of the table. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
function table.every(t, callback, callbackData) end

---Returns true if callback returns non-false value for at least a single element of the table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
function table.some(t, callback, callbackData) end

---Counts number of elements for which callback returns non-false value. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return integer
function table.count(t, callback, callbackData) end

---Calls callback for each element, returns sum of returned values. Can work
---with both array and non-array tables. If callback is missing, sums actual values in table.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return integer
function table.sum(t, callback, callbackData) end

---Returns first element and its key for which callback returns a non-false value. Can work
---with both array and non-array tables. If nothing is found, returns `nil`.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return T, TKey
function table.findFirst(t, callback, callbackData) end

---Returns first element and its key for which a certain property matches the value. If nothing is
---found, returns `nil`.
---@generic T
---@generic TKey
---@param t table<TKey, T>
---@param key string
---@param value any
---@return T, TKey
function table.findByProperty(t, key, value) end

---Returns an element and its key for which callback would return the highest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number
---@param callbackData TCallbackData?
---@return T, TKey
function table.maxEntry(t, callback, callbackData) end

---Returns an element and its key for which callback would return the lowest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number
---@param callbackData TCallbackData?
---@return T, TKey
function table.minEntry(t, callback, callbackData) end

---Runs callback for each item in a table. Can work with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback fun(item: T, key: TKey, callbackData: TCallbackData)
---@param callbackData TCallbackData?
---@return table
function table.forEach(t, callback, callbackData) end

---Creates a new table with unique elements from original table only. Optionally, a callback
---can be used to provide a key which uniqueness will be checked. Can work with both array
---and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t table<TKey, T>
---@param callback nil|fun(item: T, key: TKey, callbackData: TCallbackData): any
---@param callbackData TCallbackData?
---@return table<TKey, T>
function table.distinct(t, callback, callbackData) end

---Finds first element for which `testCallback` returns true, returns index of an element before it.
---Elements should be ordered in such a way that there would be no more elements returning false to the right
---of an element returning true.
---
---If `testCallback` returns true for all elements, would return 0. If `testCallback` returns false for all,
---returns index of the latest element.
---@generic T
---@generic TCallbackData
---@param t T[]
---@param testCallback fun(item: T, index: integer, callbackData: TCallbackData): boolean
---@param testCallbackData nil|TCallbackData
---@return integer
---@nodiscard
function table.findLeftOfIndex(t, testCallback, testCallbackData) end

---Flattens table similar to JavaScript function with the same name. Requires an array.
---@param t any[]
---@param maxLevel integer? @Default value: 1.
---@return any[]
function table.flatten(t, maxLevel) end

---Creates a new table running in steps from `startingIndex` to `endingIndex`, including `endingIndex`.
---If callback returns two values, second value is used as a key.
---@generic T
---@generic TCallbackData
---@param endingIndex integer?
---@param startingIndex integer
---@param step integer?
---@param callback fun(index: integer, callbackData: TCallbackData): T
---@param callbackData TCallbackData?
---@return T[]
---@overload fun(endingIndex: integer, callback: fun(index: integer, callbackData: any), callbackData: any)
---@overload fun(endingIndex: integer, startingIndex: integer, callback: fun(index: integer, callbackData: any), callbackData: any)
function table.range(endingIndex, startingIndex, step, callback, callbackData) end

---Creates a new table from iterator. Supports iterators returning one or two values (if two values are returned, first is considered the key,
---if not, values are simply added to a list).
---@generic T
---@param iterator fun(...): T
---@return T[]
function table.build(iterator, k, v) end

--[[ common/io.lua ]]

---Structure containing various file or directory attributes, including various flags and dates. All values are precomputed and ready to be used (there is
---no overhead in accessing them once you get the structure).
---@class io.FileAttributes
---@field fileSize integer @File size in bytes.
---@field creationTime integer @File creation time in seconds from 1970.
---@field lastAccessTime integer @File last access time in seconds from 1970.
---@field lastWriteTime integer @File last write time in seconds from 1970.
---@field exists boolean @True if file exists.
---@field isDirectory boolean @True if file is a directory.
---@field isHidden boolean @The file or directory is hidden. It is not included in an ordinary directory listing.
---@field isReadOnly boolean @A file that is read-only. Applications can read the file, but cannot write to it or delete it.
---@field isEncrypted boolean @A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.
---@field isCompressed boolean @A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.
---@field isReparsePoint boolean @A file or directory that has an associated reparse point, or a file that is a symbolic link.
local _fileAttributes = {}

--[[ common/io.lua ]]

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`.
---@param filename string @Filename.
---@param fallbackData string|nil @Data to return if file could not be read.
---@return string|nil @Returns `nil` if file couldn’t be read and there is no fallback data.
function io.load(filename, fallbackData) end

---Scan directory and call callback function for each of files, passing file name (not full name, but only name of the file) and attributes. If callback function would return
---a non-nil value, iteration will stop and value returned by callback would return from this function. This could be used to
---find a certain file without going through all files in the directory. Optionally, a mask can be used to pre-filter received files
---entries.
---
---If callback function is not provided, it’ll return list of files instead (file names only).
---
---System entries “.” and “..” will not be included in the list of files. Accessing attributes does not add extra cost.
---@generic TCallbackData
---@generic TReturn
---@param directory string @Directory to look for files in. Note: directory is relative to current directory, not to script directory. For AC in general it’s an AC root directory, but do not rely on it, instead use `ac.getFolder(ac.FolderID.Root)`.
---@param mask string? @Mask in a form of usual “*.*”. Default value: '*'.
---@param callback fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: TCallbackData): TReturn @Callback which will be ran for every file in directory fitting mask until it would return a non-nil value.
---@param callbackData TCallbackData? @Callback data that will be passed to callback as third argument, to avoid creating a capture.
---@return TReturn @First non-nil value returned by callback.
---@overload fun(directory: string, callback: fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: any), callbackData: any): any
---@overload fun(directory: string, mask: string|nil): string[]
function io.scanDir(directory, mask, callback, callbackData) end

---Returns list of logical drives, each drive in “A:“ format.
---@return string[]
function io.scanDrives() end

---Returns list of entry names from a ZIP-file.
---@param filename string
---@return string[]
function io.scanZip(filename) end

--[[ common/os.lua ]]

---@class os.ConsoleProcessResult
---@field exitCode integer @If process finished successfully, 0. If failed to get the exit code, -1.
---@field stdout string @Contents of stdout stream of ran process.
---@field stderr string @Contents of stderr stream of ran process. Would be set only if `separateStderr` parameter was set to true.

--[[ common/os.lua ]]

---Module with additional functions to help deal with operating system.
os = {}

---Opens regular Windows file opening dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: string, folder: string, fileName: string, fileTypes: { name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|"{\n  title = 'Open',\n  defaultFolder = ac.getFolder(ac.FolderID.Root),\n  fileTypes = {\n    {\n      name = 'Images',\n      mask = '*.png;*.jpg;*.jpeg;*.psd'\n    }\n  },\n  addAllFilesFileType = true,\n  flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.FileMustExist)\n}" "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`string`): Default folder if there is not a recently used folder value available.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `fileTypes` (`{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Open button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.openFileDialog(params, callback) end

---Opens regular Windows file saving dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: string, defaultExtension: string, folder: string, fileName: string, saveAsItem: string, fileTypes: { name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|"{\n  title = 'Save',\n  defaultFolder = ac.getFolder(ac.FolderID.Root),\n  fileTypes = {\n    {\n      name = 'Images',\n      mask = '*.png;*.jpg;*.jpeg;*.psd'\n    }\n  },\n  addAllFilesFileType = true,\n  flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.OverwritePrompt, os.DialogFlags.NoReadonlyReturn)\n}" "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`string`): Default folder if there is not a recently used folder value available.\n- `defaultExtension` (`string`): Sets the default extension to be added to file names.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `saveAsItem` (`string`): Ann item to be used as the initial entry in a Save As dialog.\n- `fileTypes` (`{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Save button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.saveFileDialog(params, callback) end

---Run a console process in background with given arguments, return exit code and output in callback. Launched process will be tied
---to AC process to shut down with AC (works only on Windows 8 and newer).
---@param params {filename: string, arguments: string[], rawArguments: boolean, workingDirectory: string, timeout: integer, environment: table, stdin: string, separateStderr: boolean, terminateWithScript: boolean}|"{ filename = '', arguments = {} }" "Table with properties:\n- `filename` (`string`): Application filename.\n- `arguments` (`string[]`): Arguments (quotes will be added automatically unless `rawArguments` is set to true).\n- `rawArguments` (`boolean`): Set to `true` to disable any arguments processing and pass them as they are, simply joining them with a space symbol.\n- `workingDirectory` (`string`): Working directory.\n- `timeout` (`integer`): Timeout in milliseconds. If above zero, process will be killed after given time has passed.\n- `environment` (`table`): If set to a table, values from that table will be used as environment variables instead of inheriting ones from AC process.\n- `stdin` (`string`): Optional data to pass to a process in stdin pipe.\n- `separateStderr` (`boolean`): Store stderr data in a separate string.\n- `terminateWithScript` (`boolean`): Terminate process if this Lua script were to terminate (for example, during reload)."
---@param callback nil|fun(err: string, data: os.ConsoleProcessResult)
function os.runConsoleProcess(params, callback) end

--[[ common/timer.lua ]]

---Runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun()
---@param delay number? @Delay time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setTimeout(callback, delay, uniqueKey) end

---Repeteadly runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun()
---@param period number? @Period time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setInterval(callback, period, uniqueKey) end

---Stops timeout.
---@param cancellationID integer @Value earlier retuned by `setTimeout()`. If a non-numerical value is passed (like a `nil`), call is ignored and returns `false`.
---@return boolean @True if timeout with such ID has been found and stopped.
function clearTimeout(cancellationID) end

---Stops interval.
---@param cancellationID integer @Value earlier retuned by `setInterval()`.
---@return boolean @True if interval with such ID has been found and stopped.
function clearInterval(cancellationID) end

--[[ common/ac_extras_ini.lua ]]

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@param format ac.INIFormat 
---@param sections table 
---@return ac.INIConfig
function ac.INIConfig(format, sections) end

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@class ac.INIConfig
---@field sections table<string, table<string, string[]>> @Sections storing actual data.
---@field format ac.INIFormat? @Format used when creating a config. Default value: `ac.INIFormat.Default`.
---@field filename string? @Optional filename for configs loaded from a file.
local _ac_INIConfig = nil

---Get value from parsed INI file. Note: getting vector values creates them anew, so if you’re going to use a value often, consider
---caching it locally.
---@generic T
---@param section string @Section name.
---@param key string @Value key.
---@param defaultValue T @Defines type of value to return, is returned if value is missing. If not set, list of strings is returned.
---@param offset integer? @Optional 1-based offset for data parsed in CSP format (in case value contains several items). Default value: 1.
---@return T
function _ac_INIConfig:get(section, key, defaultValue, offset) end

---Attempts to load a 1D-to-1D LUT from an INI file, supports both inline “(|X=Y|…|)” LUTs and separate files next to configs (only
---for configs loaded by filename or from car data)
---@return ac.DataLUT11? @Returns `nil` if there is no such key or no such file.
function _ac_INIConfig:tryGetLut(section, key) end

---Iterates over sections of INI file with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, section in iniConfig:iterate('LIGHT') do
---  print('Color: '..iniConfig:get(section, 'COLOR', 'red'))
---end
---```
---@param prefix string @Prefix for section names.
---@param noPostfixForFirst boolean? @Only for default INI format. If set to `true`, first section would not have “_0” postfix.
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterate(prefix, noPostfixForFirst) end

---Iterates over values of INI section with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, key in iniConfig:iterateValues('LIGHT_0', 'POSITION', true) do
---  print('Position: '..tostring(iniConfig:get('LIGHT_0', key, vec3())))
---end
---```
---@param prefix string @Prefix for section names.
---@param digitsOnly boolean? @If set to `true`, would only collect keys consisting of a prefix and a number (useful for configs with extra properties).
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterateValues(section, prefix, digitsOnly) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param section string @Section name.
---@param defaults T @Table with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapSection(section, defaults) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param defaults T @Table with section names and sub-tables with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapConfig(defaults) end

---Set an INI value. Pass `nil` as value to remove it.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:set(section, key, value) end

---Set an INI value and save file immediattely using special old Windows function to edit a single INI value. Compatible only with default
---INI format. Doesn’t provide major peformance improvements, but might be useful if you prefer to keep original formatting as much as possible
---when editing a single value only.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return boolean @Returns `true` if new value is different and config was saved.
function _ac_INIConfig:setAndSave(section, key, value) end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_ini.lua ]]

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a boolean or, if it’s missing, `nil`.
ac.INIConfig.OptionalBoolean = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a number or, if it’s missing, `nil`.
ac.INIConfig.OptionalNumber = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a string or, if it’s missing, `nil`.
ac.INIConfig.OptionalString = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a list of original values or, if it’s missing, `nil`.
ac.INIConfig.OptionalList = {}

---Parse INI config from a string.
---@param data string @Serialized INI data.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@return ac.INIConfig
function ac.INIConfig.parse(data, format) end

---Load INI file, optionally with includes.
---@param filename string @INI config filename.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@param includeFolders string[]? @Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). If not set, parent folder for config filename is used.
---@return ac.INIConfig
function ac.INIConfig.load(filename, format, includeFolders) end

---Load car data INI file. Supports “data.acd” files as well. Returned files might be tweaked by
---things like custom physics virtual tyres. To get original file, use `ac.INIConfig.load()`.
---
---Returned file can’t be saved.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.carData(carIndex, fileName) end

---Load track data INI file. Can be used by track scripts which might not always  have access to those files directly.
---
---Returned file can’t be saved.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.trackData(fileName) end

---Returns config with extra online options, the ones that can be set with Content Manager.
---@return ac.INIConfig|nil @If not an online session, returns `nil`.
function ac.INIConfig.onlineExtras() end

---Load config of a CSP module by its name.
---@param cspModuleID ac.CSPModuleID @Name of a CSP module.
---@return ac.INIConfig
function ac.INIConfig.cspModule(cspModuleID) end

---Load config of the current Lua script (“settings.ini” in script directory and settings overriden by user, meant to be customizable with Content Manager). Can’t
---be changed by script directly.
---@return ac.INIConfig
function ac.INIConfig.scriptSettings() end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_datalut.lua ]]

---Creates a new empty LUT. Use `ac.Lut:add(input, output)` to fill it with data.
---@return ac.DataLUT11
function ac.DataLUT11() end

---Parse LUT from a string in “(|X1=Y1|X2=Y2|…|)” format.
---@param data string @Serialized LUT data.
---@return ac.DataLUT11
function ac.DataLUT11.parse(data) end

---Load LUT file.
---@param filename string @LUT filename.
---@return ac.DataLUT11
function ac.DataLUT11.load(filename) end

---Load car data LUT file. Supports “data.acd” files as well.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'power.lut'`.
---@return ac.DataLUT11
function ac.DataLUT11.carData(carIndex, fileName) end

--[[ common/ac_extras_datalut.lua ]]

---Simple 1D-to-1D lookup table wrapper, helps to deal with all those “.lut“ files in car data.
---@class ac.DataLUT11
---@field useCubicInterpolation boolean @Set to `true` to use cubic interpolation. Default value: `false`.
---@field extrapolate boolean @Set to `true` to extrapolate if requested value is outside of the data available.
local _ac_DataLUT11 = nil

---Add a new value to LUT.
---@param input number
---@param output number
---@return ac.DataLUT11 @Returns self for easy chaining.
function _ac_DataLUT11:add(input, output) end

---Returns data boundaries.
---@return vec2 @Minimum input and output.
---@return vec2 @Maximum input and output.
function _ac_DataLUT11:bounds() end

---Computes a LUT value using either linear or cubic interpolation (set field `ac.DataLUT11.useCubicInterpolation` to
---`true` to use cubic interpolation).
---@param input number
---@return number
function _ac_DataLUT11:get(input) end

---Returns input value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointInput(index) end

---Returns output value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointOutput(index) end

--[[ common/ac_extras_connect.lua ]]

---Creates a new shared structure to quickly exchange data between different Lua scripts within a session. Example:
---```
---local sharedData = ac.connect{
---  ac.StructItem.key('myChannel'),        -- optional, to avoid collisions
---  someString = ac.StructItem.string(24), -- 24 is for capacity
---  someInt = ac.StructItem.int(),
---  someDouble = ac.StructItem.double(),
---  someVec = ac.StructItem.vec3()
---}
---```
---
---Note: to connect two scripts, both of them chould use `ac.connect()` and pass exactly the same layouts. Also, consider using more
---specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
---used somewhere else, use `weatherBrightnessValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.
---
---For safety reasons, car scripts can only connect to other car scripts, and track scripts can only connect to other track scripts.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@param keepLive boolean? @Set to true to keep structure even if any references were removed or script was unloaded.
---@param namespace nil|ac.SharedNamespace @Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.
---@return T
function ac.connect(layout, keepLive, namespace) end

--[[ common/ac_struct_item.lua ]]

---Helper to define structures in a safe and secure manner. Create a new table and use values returned
---by these methods as values and pass it to `ac.connect()` or `ac.registerOnlineMessageType()`.
---
---Few notes:
---- Don’t worry about order, elements will be reordered automatically (also, if using associative table
---  in Lua, order would not be strictly defined anyway);
---- If you want to make sure to avoid possible collisions (those functions use format of layout for identifying
---  structures and establishing connections), use `ac.StructItem.key('myOwnUniqueThing')`;
---- If you want to save space (for example, with online messages), there are virtual types `.norm…` and `.unorm…`
---  which would give you floating point values from -1 to 1 (or for 0 to 1 for .unorm… variants), but use 8-bit
---  and 16-bit values for storing, they could help. Also make sure to limit capacity of your strings as much as
---  possible;
---- When accessing string, its checksum will be calculated and compared with checksum of previously accessed value,
---  thus avoiding creating new entities when unnecessary. While it helps with GC, it could incur some overhead
---  on accessing values, so if you need to access string numerous times (let’s say, in a loop), consider copying
---  a reference to it locally.
ac.StructItem = {}

---@return nil
function ac.StructItem.key(key) end

---@return number
function ac.StructItem.half() end

---@return number
function ac.StructItem.float() end

---@return number
function ac.StructItem.double() end

---@return number
function ac.StructItem.norm8() end

---@return number
function ac.StructItem.unorm8() end

---@return number
function ac.StructItem.norm16() end

---@return number
function ac.StructItem.unorm16() end

---@return integer
function ac.StructItem.int16() end

---@return integer
function ac.StructItem.uint16() end

---@return integer
function ac.StructItem.int32() end

---@return integer
function ac.StructItem.uint32() end

---@return integer
function ac.StructItem.int64() end

---@return integer
function ac.StructItem.uint64() end

---@return boolean
function ac.StructItem.boolean() end

---@return integer
function ac.StructItem.char() end

---@return integer
function ac.StructItem.byte() end

---@return vec2
function ac.StructItem.vec2() end

---@return vec3
function ac.StructItem.vec3() end

---@return vec4
function ac.StructItem.vec4() end

---@return rgb
function ac.StructItem.rgb() end

---@return rgbm
function ac.StructItem.rgbm() end

---@return hsv
function ac.StructItem.hsv() end

---@return quat
function ac.StructItem.quat() end

---@generic T
---@param elementType T
---@param size integer
---@return T[]
function ac.StructItem.array(elementType, size) end

---@return string
function ac.StructItem.string(capacity) end

--[[ common/ac_extras_hashspace.lua ]]

---@class ac.HashSpaceItem
local HashSpaceItem = class('HashSpaceItem')

---Returns ID associated with an item.
---@return integer
function HashSpaceItem:id() end

---Moves an item to a position.
---@param pos vec3
function HashSpaceItem:update(pos) end

---Removes item from its space.
function HashSpaceItem:dispose() end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@param cellSize number @Should be about twice as large as your largest entity.
---@return ac.HashSpace
function ac.HashSpace(cellSize) end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@class ac.HashSpace
local _ac_HashSpace = nil

---Iterates items around given position.
---@generic T
---@param pos vec3
---@param callback fun(id: integer, callbackData: T)
---@param callbackData T?
function _ac_HashSpace:iterate(pos, callback, callbackData) end

---Checks if there are any items around given position.
---@param pos vec3
---@return boolean
function _ac_HashSpace:anyAround(pos) end

---Count amount of items around given position.
---@param pos vec3
---@return integer
function _ac_HashSpace:count(pos) end

---Returns raw pointers for given position for manual iteration. Be careful!
---@param pos vec3
---@return any, any
function _ac_HashSpace:rawPointers(pos) end

---Adds a new dynamic item to the grid. Each item gets a new ID.
---@return ac.HashSpaceItem
function _ac_HashSpace:add() end

---Adds a fixed item to the grid, with predetermined ID. Avoid mixing dynamic and fixed items in the same grid.
---@param id integer
---@param pos vec3
function _ac_HashSpace:addFixed(id, pos) end

--[[ common/ac_extras_numlut.lua ]]

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lut = ac.Lut([[
--- -100 |  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -90 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -20 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---]], { 2 })
---assert(lut:calculate(-95)[1] == 1)
---```
---@param data string @String with LUT data, in a format similar to AC LUT formats. Please note: rows must be ordered for efficient binary search.
---@param hsvColumns integer[] @1-based indices of columns storing HSV data. Such columns, of course, will be interpolated differently (for example, mixing hues 350 and 20 would produce 10).
---@return ac.Lut
function ac.Lut(data, hsvColumns) end

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lut = ac.Lut([[
--- -100 |  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -90 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -20 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---]], { 2 })
---assert(lut:calculate(-95)[1] == 1)
---```
---@class ac.Lut
---@explicit-contructor ac.Lut
local _ac_Lut = nil

---Interpolate for a given input, return a newly created table. Note: consider using `:calculateTo()` instead to avoid re-creating tables, it would work much more efficiently.
---@param input number
---@return number[]
function _ac_Lut:calculate(input) end

---Interpolate for a given input, write result to a given table.
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function _ac_Lut:calculateTo(output, input) end

---@type ac.Lut
ac.LutCpp = ac.Lut

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lutJit = ac.LutJit:new{ data = {
---  { input = -100, output = {  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -90, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -20, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  }, hsvRows = { 2 }}
---assert(lutJit:calculate(-95)[1] == 1)
---```
---Obsolete. Use `ac.Lut` instead, with faster C++ implementation.
---@class ac.LutJit
---@deprecated
ac.LutJit = {}

---Creates new ac.LuaJit instance. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param data any
---@param hsvRows integer[] @ 1-based indices of columns (not rows) storing HSV values in them.
---@return table
function ac.LutJit:new(o, data, hsvRows) end

---Computes a new value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param input number
---@return number[]
function ac.LutJit:calculate(input) end

---Computes a new value to a preexisting HSV value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function ac.LutJit:calculateTo(output, input) end

--[[ common/ac_extras_onlineevent.lua ]]

---Creates a new type of online event to exchange between scripts running on different clients in an online
---race. Example:
---```
---local chatMessageEvent = ac.OnlineEvent({
---  -- message structure layout:
---  message = ac.StructItem.string(50),
---  mood = ac.StructItem.float(),
---}, function (sender, data)
---  -- got a message from other client (or ourselves; in such case `sender.index` would be 0):
---  ac.debug('Got message: from', sender and sender.index or -1)
---  ac.debug('Got message: text', data.message)
---  ac.debug('Got message: mood', data.mood)
---end)
---
----- sending a new message:
---chatMessageEvent{ message = 'hello world', mood = 5 }
---```
---
---Note: to exchange messages between two scripts, both of them chould use `ac.OnlineEvent()` and pass exactly the same layouts. Also, consider using more
---specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
---used somewhere else, use `mySpecificValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.
---
---For safety reasons, car scripts can only exchange messages with other car scripts, and track scripts can only exchange messages with other track scripts.
---
---Each message should be smaller than 175 bytes. At least 200 ms should pass between sending messages. Don’t use this system to exchange data too often: at
---current stage, it uses chat messages to transfer data, so it’s far from optimal.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@param callback fun(sender: ac.StateCar|nil, message: T) @Callback that will be called when a new message of this type is received. Note: it would be called even if message was sent from this script. Use `sender` to check message origin: if it’s `nil`, message has come from the server, if its `.index` is 0, message has come from this client (and possibly this script).
---@param namespace nil|ac.SharedNamespace @Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.
---@return fun(message: T, repeatForNewConnections: nil|boolean): boolean @Function for sending new messages of newly created type. Pass a new table to set fields of a new message. If any field is missing, it would be set to default zero state. Set `repeatForNewConnections` to `true` if this message should be re-sent later for newly connected cars (good if you’re announcing a change of state, like, for example, a custom car paint color). If after setting it to `true` a function would be called again without `repeatForNewConnections` set to `true`, further re-sending will be deactivated. Function returns `true` if message has been sent successfully, or `false` otherwise (for example, if rate limits were exceeded).
function ac.OnlineEvent(layout, callback, namespace) end

--[[ common/ac_extras_connectmmf.lua ]]

---Opens shared memory file for reading.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@return T
function ac.readMemoryMappedFile(filename, layout) end

---Opens shared memory file for writing.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@return T
function ac.writeMemoryMappedFile(filename, layout) end

--[[ common/ac_general_utils.lua ]]

---Estimates lap time and sector times for main car using AC function originally used by Time Attack mode. Could be
---helpful in creating custom time attack modes. Uses “ideal_line.ai” from “track folder/data”, so might not work
---well with mods. If that file is missing, returns nil.
---@return {lapTimeMs: integer, sectorTimesMs: integer[]}|nil @Returns table with times in milliseconds, or `nil` if  “ideal_lane.ai” is missing.
function ac.evaluateLapTime() end

--[[ common/ac_music.lua ]]

---Information about currently playing track. Use function `ac.currentlyPlaying()` to get
---a reference to it.
---
---To draw album cover, pass `ac.MusicData` as an argument to something like `ui.image()`.
---@class ac.MusicData
---@field isPlaying boolean @If `true`, music is currently playing.
---@field hasCover boolean @If `true`, album cover is present.
---@field title string @Name of currently playing track.
---@field album string @Name of currently playing album (if not available, an empty string).
---@field artist string @Name of currently playing artist (if not available, an empty string).
---@field sourceID string @Source ID from where track is coming from. To draw an icon for it, pass it as Icon24 ID. You can check if there is an icon using `ui.isKnownIcon24(playing.sourceID)`.
---@field albumTracksCount integer @Number of tracks in current album, or 0 if value is not available.
---@field trackNumber integer @1-based track number in current album, or 0 if value is not available.
---@field trackDuration integer @Track duration in seconds, or -1 if value is not available.
---@field trackPosition integer @Track position in seconds, or -1 if value is not available.
local _musicData = {}

--[[ common/ac_music.lua ]]

---Syncs information about currently playing music and returns a table with details. Takes data from
---Windows 10 Media API, or from other sources configured in Music module of CSP.
---@return ac.MusicData
function ac.currentlyPlaying() end

--[[ common/ac_storage.lua ]]

---@class ac.StoredValue
local _ac_StoredValue = {}

---@return string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:get() end

---@param value string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:set(value) end

---Storage function. Easiest way to use is to pass it a table with default values — it would give you a table back
---which would load values on reads and save values on writes. Values have to be either strings, numbers, booleans,
---vectors or colors. Example:
---```
---local storedValues = ac.storage{
---  someKey = 15,
---  someStringValue = 20
---}
---storedValues.someKey = 20
---```
---Alternatively, you can use it as a function which would take a key and a default value and return you an
---`ac.StoredValue` wrapper with methods `:get()` and `:set(newValue)`:
---```
---local stored = ac.storage('someKey', 15)
---stored:get()
---stored:set(20)
---```
---Or, just access it directly in `localStorage` style of JavaScript. Similar to JavaScript, this way you can only store
---strings:
---```
---ac.storage.key = 'value'
---ac.debug('loaded', ac.storage.key)
---```
---Data will be saved in “Documents\Assetto Corsa\cfg\extension\state\lua”, in corresponding subfolder. Actual writing
---will happen a few seconds after new value was pushed, and only if value was changed, so feel free to use this function
---to write things often.
---@generic T
---@param layout T
---@param keyPrefix string|nil @Optional parameter for adding a prefix to keys.
---@return T
---@overload fun(key: string, value: string|number|boolean|vec2|vec3|vec4|rgb|rgbm): ac.StoredValue
function ac.storage(layout, keyPrefix) end

--[[ common/ac_storage.lua ]]

---Checks if storage table created by `ac.storage(table)` has a certain key or not.
---@param storage any
---@param key string
---@return boolean
function ac.storageHasKey(storage, key) end

--[[ common/ac_configs.lua ]]

---@class ac.ConfigProvider
local _ac_ConfigProvider = {}

---@param section string
---@param key string
---@param defaultValue boolean|nil
---@return boolean
function _ac_ConfigProvider.bool(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue number
---@return number
function _ac_ConfigProvider.number(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue string|nil
---@return string
function _ac_ConfigProvider.string(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgb|nil
---@return rgb
function _ac_ConfigProvider.rgb(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgbm|nil
---@return rgbm
function _ac_ConfigProvider.rgbm(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec2|nil
---@return vec2
function _ac_ConfigProvider.vec2(section, key, defaultValue) end
---@param section string
---@param key string
---@param defaultValue vec3|nil
---@return vec3
function _ac_ConfigProvider.vec3(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec4|nil
---@return vec4
function _ac_ConfigProvider.vec4(section, key, defaultValue) end

---Reads a value from the config of currently loaded track. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called without arguments, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(): ac.ConfigProvider
function ac.getTrackConfig(section, key, defaultValue) end

---Reads a value from the config of a car. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called with car index only, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param carIndex integer @0-based car index.
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(carIndex: integer): ac.ConfigProvider
function ac.getCarConfig(carIndex, section, key, defaultValue) end

--[[ common/ac_reftypes.lua ]]

---Stores a boolean value and can be used as a reference to it.
---@param value boolean "Stored value."
---@return refbool
function refbool(value) end

---Stores a boolean value and can be used as a reference to it.
---@class refbool
---@field value boolean @Stored value.
local refbool = nil

---@return boolean
function refbool.isrefbool(x) end

---For easier use with UI controls.
---@param newValue boolean|`true`|`false`
---@return refbool
function refbool:set(newValue) end

---Stores a numerical value and can be used as a reference to it.
---@param value number "Stored value."
---@return refnumber
function refnumber(value) end

---Stores a numerical value and can be used as a reference to it.
---@class refnumber
---@field value number @Stored value.
local refnumber = nil

---@return boolean
function refnumber.isrefnumber(x) end

---For easier use with UI controls.
---@param newValue number
---@return refnumber
function refnumber:set(newValue) end

--[[ common/ac_dualsense.lua ]]

---Return table with gamepad indices for keys and 0-based indices of associated cars for values.
---@return table<integer, integer>
function ac.getDualSenseControllers() end

--[[ common/ac_web.lua ]]

---@class WebResponse
---@field status integer
---@field headers table<string, string>
---@field body string
local _webResponse = {}

---Two possible ways to present payload: either as a string with data, or a table with a key `'filename'`.
---Second way can be used as a shortcut for `io.loadAsync()` (it loads data asyncronously).
---Data string can contain zeroes.
---@alias WebPayload string|{filename: string}

--[[ common/ac_web.lua ]]

---Web module.
web = {}

---Sends a GET HTTP request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.get(url, headers, callback) end

---Sends a POST HTTP request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.post(url, headers, data, callback) end

---Sends a custom HTTP request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param method "'GET'"|"'POST'"|"'PUT'"|"'HEAD'"|"'DELETE'"|"'PATCH'"|"'OPTIONS'" @HTTP method.
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(method: string, url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(method: string, url: string, callback: fun(err: string, response: WebResponse))
function web.request(method, url, headers, data, callback) end

--[[ common/stringify.lua ]]

---Serialize Lua value (table, number, string, etc.) in a Lua table format (similar to how `JSON.stringify` in JavaScript
---generates a thing with JavaScript syntax). Format seems to be called Luaon. Most of Lua entities are supported, including array-like tables, table
---tables and mixed ones. CSP API things, such as vectors or colors, are also supported. For things like threads,
---functions or unknown cdata types instead a placeholder object will be created.
---
---Circular references also result in creating similar objects, for example: `t = {1, 2, 3, t}` would result in
---`{ 1, 2, 3, { type = 'circular reference' } }`.
---
---If any table in given data would have a `__stringify()` function, it would be called as a method (so first argument
---would be the table with `__stringify` itself). If that function would return a string, that string will be used
---instead of regular table serialization. The idea is for classes to define a method like this and output a line of code
---which could be used to create a new instance like this on deserialization. Note: for such like to use a custom function
---like a class constructor, you would either need to register that function with a certain name or provide a table referring
---to it on deserialization. That’s because although deserialization uses `load()` function to parse and run data as Lua code,
---it wouldn’t allow code to access existing functions by default.
---@param obj table|number|string|boolean|nil @Object o serialize.
---@param compact boolean? @If true, resulting string would not have spaces and line breaks, slightly faster and a lot more compact.
---@param depthLimit integer? @Limits how deep serialization would go. Default value: 20.
---@return string @String with input data presented in Lua syntax.
function stringify(obj, compact, depthLimit) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Would raise an error if failed to parse or if any of initializers would raise an error.
---@param serialized string @Serialized data.
---@param namespace table<string, function>|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@return table|number|string|boolean|nil
function stringify.parse(serialized, namespace) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.
---@generic T
---@param serialized string @Serialized data.
---@param namespace table<string, function>|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@param fallback T|nil @Value to return if parsing failed.
---@return T
function stringify.tryParse(serialized, namespace, fallback) end

---Registers a new initializer function with a given name.
---@param name string @Name of an initializer (how serialized data would refer to it).
---@param fn function @Initializer function (returning value for serialized data to use).
---@overload fun(class: ClassDefinition)
function stringify.register(name, fn) end

---Serialization substep. Works similar to `stringify()` itself, but instead of returning string simply adds new terms to
---`out` table. Use it in custom `__stringify` methods for serializing child items if you need the best performance.
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
function stringify.substep(out, ptr, obj, lineBreak, depthLimit) end

---A small helper to add as a parent class for EmmyLua to work better.
---@class ClassStringifiable : ClassBase
local _classStringifiable = {}

---Serialize instance of class. Can either return a `string`, or construct it into `out` table and return a new position in it. String itself should be a like of
---Lua code which would reconstruct the object on deserialization. Don’t forget to either register referred function with `stringify.register()` or provide
---a reference to it in `namespace` table with `stringify.parse()`.
---
---Note: to serialize sub-objects, such as constructor arguments, you can use `stringify()` or `stringify.substep()` if you’re using an approach with
---manually constructing `out` table. Alternatively for basic types you can use `string.format()`: “%q” would give you a string in Lua format, so you can use it
---like so:
---```
---function MyClass:__serialize()
---  return string.format('MyClass(%q, %s)', self.stringName, self.numericalCounter)
---end
---```
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
---@overload fun(): string @Simpler version which should work well in 98% of times. Use a more detailed one only if you have a ton of objects and need to improve performance.
function _classStringifiable:__stringify(out, ptr, obj, lineBreak, depthLimit) end

--[[ enums.lua ]]

---@alias render.PassID
---| `render.PassID.None` @No special options.
---| `render.PassID.Main` @Value: 0x1.
---| `render.PassID.Mirror` @Value: 0x2.
---| `render.PassID.CubeMap` @Value: 0x4.
---| `render.PassID.Extras` @Value: 0x8.
---| `render.PassID.All` @Value: 0xf.
render.PassID = {
  None = 0x0, ---No special options.
  Main = 0x1, ---Value: 0x1.
  Mirror = 0x2, ---Value: 0x2.
  CubeMap = 0x4, ---Value: 0x4.
  Extras = 0x8, ---Value: 0x8.
  All = 0xf, ---Value: 0xf.
}

---@alias render.BlendMode
---| `render.BlendMode.Opaque` @Value: 0.
---| `render.BlendMode.AlphaBlend` @Value: 1.
---| `render.BlendMode.AlphaTest` @Value: 2.
---| `render.BlendMode.BlendAdd` @Value: 4.
---| `render.BlendMode.BlendMultiply` @Value: 5.
---| `render.BlendMode.BlendSummingAlpha` @Value: 8.
---| `render.BlendMode.BlendSubtract` @Value: 13.
---| `render.BlendMode.BlendAccurate` @Value: 15.
---| `render.BlendMode.BlendPremultiplied` @Value: 16.
render.BlendMode = {
  Opaque = 0, ---Value: 0.
  AlphaBlend = 1, ---Value: 1.
  AlphaTest = 2, ---Value: 2.
  BlendAdd = 4, ---Value: 4.
  BlendMultiply = 5, ---Value: 5.
  BlendSummingAlpha = 8, ---Value: 8.
  BlendSubtract = 13, ---Value: 13.
  BlendAccurate = 15, ---Value: 15.
  BlendPremultiplied = 16, ---Value: 16.
}

---@alias render.CullMode
---| `render.CullMode.Front` @Value: 0.
---| `render.CullMode.Back` @Value: 1.
---| `render.CullMode.None` @Value: 2.
---| `render.CullMode.Wireframe` @Value: 4.
---| `render.CullMode.WireframeAntialised` @Value: 7.
---| `render.CullMode.ShadowsDouble` @Value: 9.
---| `render.CullMode.ShadowsSingle` @Value: 10.
render.CullMode = {
  Front = 0, ---Value: 0.
  Back = 1, ---Value: 1.
  None = 2, ---Value: 2.
  Wireframe = 4, ---Value: 4.
  WireframeAntialised = 7, ---Value: 7.
  ShadowsDouble = 9, ---Value: 9.
  ShadowsSingle = 10, ---Value: 10.
}

---@alias render.DepthMode
---| `render.DepthMode.Normal` @Value: 0.
---| `render.DepthMode.ReadOnly` @Value: 1.
---| `render.DepthMode.Off` @Value: 2.
---| `render.DepthMode.LessEqual` @Value: 3.
---| `render.DepthMode.ReadOnlyLessEqual` @Value: 4.
render.DepthMode = {
  Normal = 0, ---Value: 0.
  ReadOnly = 1, ---Value: 1.
  Off = 2, ---Value: 2.
  LessEqual = 3, ---Value: 3.
  ReadOnlyLessEqual = 4, ---Value: 4.
}

---@alias render.GLPrimitiveType
---| `render.GLPrimitiveType.Lines` @Value: 0.
---| `render.GLPrimitiveType.LinesStrip` @Value: 1.
---| `render.GLPrimitiveType.Triangles` @Value: 2.
---| `render.GLPrimitiveType.Quads` @Value: 3.
render.GLPrimitiveType = {
  Lines = 0, ---Value: 0.
  LinesStrip = 1, ---Value: 1.
  Triangles = 2, ---Value: 2.
  Quads = 3, ---Value: 3.
}

---@alias render.FontAlign
---| `render.FontAlign.Left` @Value: 0.
---| `render.FontAlign.Right` @Value: 1.
---| `render.FontAlign.Center` @Value: 2.
render.FontAlign = {
  Left = 0, ---Value: 0.
  Right = 1, ---Value: 1.
  Center = 2, ---Value: 2.
}

---@alias render.ShadersType
---| `render.ShadersType.Main` @Not recommended to use here.
---| `render.ShadersType.Simplified` @Value: 13.
---| `render.ShadersType.SimplifiedWithLights` @Value: 14.
---| `render.ShadersType.Simplest` @Value: 15.
---| `render.ShadersType.SampleColor` @Value: 17.
---| `render.ShadersType.SampleNormal` @Value: 18.
---| `render.ShadersType.SampleEmissive` @Value: 19.
---| `render.ShadersType.Shadows` @Value: 25.
render.ShadersType = {
  Main = 0, ---Not recommended to use here.
  Simplified = 13, ---Value: 13.
  SimplifiedWithLights = 14, ---Value: 14.
  Simplest = 15, ---Value: 15.
  SampleColor = 17, ---Value: 17.
  SampleNormal = 18, ---Value: 18.
  SampleEmissive = 19, ---Value: 19.
  Shadows = 25, ---Value: 25.
}

---These flags can be combined together with `bit.bor()`.
---@alias render.TextureMaskFlags
---| `render.TextureMaskFlags.Default` @Default: use alpha and red channel as multipliers.
---| `render.TextureMaskFlags.UseColorAverage` @Use average of RGB values.
---| `render.TextureMaskFlags.UseAlpha` @Use alpha of a mask as a multiplier.
---| `render.TextureMaskFlags.UseRed` @Use red channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseGreen` @Use green channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseBlue` @Use blue channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedAlpha` @Use inverted alpha of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedRed` @Use inverted red channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedGreen` @Use inverted green channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedBlue` @Use inverted blue channel of a mask as a multiplier.
---| `render.TextureMaskFlags.MixColors` @Use colors of a mask as a multiplier for main colors.
---| `render.TextureMaskFlags.MixInvertedColors` @Use inverted colors of a mask as a multiplier for main colors.
---| `render.TextureMaskFlags.AltUV` @Use alternative UV (for projecting textures onto meshes, uses original mesh UV instead of projection UV).
render.TextureMaskFlags = {
  Default = 0x6, ---Default: use alpha and red channel as multipliers.
  UseColorAverage = 0x1, ---Use average of RGB values.
  UseAlpha = 0x2, ---Use alpha of a mask as a multiplier.
  UseRed = 0x4, ---Use red channel of a mask as a multiplier.
  UseGreen = 0x8, ---Use green channel of a mask as a multiplier.
  UseBlue = 0x10, ---Use blue channel of a mask as a multiplier.
  UseInvertedAlpha = 0x20, ---Use inverted alpha of a mask as a multiplier.
  UseInvertedRed = 0x40, ---Use inverted red channel of a mask as a multiplier.
  UseInvertedGreen = 0x80, ---Use inverted green channel of a mask as a multiplier.
  UseInvertedBlue = 0x100, ---Use inverted blue channel of a mask as a multiplier.
  MixColors = 0x200, ---Use colors of a mask as a multiplier for main colors.
  MixInvertedColors = 0x400, ---Use inverted colors of a mask as a multiplier for main colors.
  AltUV = 0x10000, ---Use alternative UV (for projecting textures onto meshes, uses original mesh UV instead of projection UV).
}

---@alias render.AntialiasingMode
---| `render.AntialiasingMode.None` @No antialiasing.
---| `render.AntialiasingMode.FXAA` @Blurry and slower than CMAA.
---| `render.AntialiasingMode.CMAA` @Faster and sharper option comparing to FXAA.
---| `render.AntialiasingMode.ExtraSharpCMAA` @Like CMAA, but even sharper.
render.AntialiasingMode = {
  None = 0, ---No antialiasing.
  FXAA = 101, ---Blurry and slower than CMAA.
  CMAA = 102, ---Faster and sharper option comparing to FXAA.
  ExtraSharpCMAA = 103, ---Like CMAA, but even sharper.
}

---@alias render.TextureFormat
---| `render.TextureFormat.R32G32B32A32.Float` @Value: '2'.
---| `render.TextureFormat.R32G32B32A32.UInt` @Value: '3'.
---| `render.TextureFormat.R32G32B32A32.SInt` @Value: '4'.
---| `render.TextureFormat.R32G32B32.Float` @Value: '6'.
---| `render.TextureFormat.R32G32B32.UInt` @Value: '7'.
---| `render.TextureFormat.R32G32B32.SInt` @Value: '8'.
---| `render.TextureFormat.R32G32.Float` @Value: '16'.
---| `render.TextureFormat.R32G32.UInt` @Value: '17'.
---| `render.TextureFormat.R32G32.SInt` @Value: '18'.
---| `render.TextureFormat.R32.Float` @Value: '41'.
---| `render.TextureFormat.R32.UInt` @Value: '42'.
---| `render.TextureFormat.R32.SInt` @Value: '43'.
---| `render.TextureFormat.R16G16B16A16.Float` @Value: '10'.
---| `render.TextureFormat.R16G16B16A16.UNorm` @Value: '11'.
---| `render.TextureFormat.R16G16B16A16.UInt` @Value: '12'.
---| `render.TextureFormat.R16G16B16A16.SNorm` @Value: '13'.
---| `render.TextureFormat.R16G16B16A16.SInt` @Value: '14'.
---| `render.TextureFormat.R16G16.Float` @Value: '34'.
---| `render.TextureFormat.R16G16.UNorm` @Value: '35'.
---| `render.TextureFormat.R16G16.UInt` @Value: '36'.
---| `render.TextureFormat.R16G16.SNorm` @Value: '37'.
---| `render.TextureFormat.R16G16.SInt` @Value: '38'.
---| `render.TextureFormat.R16.Float` @Value: '54'.
---| `render.TextureFormat.R16.UNorm` @Value: '56'.
---| `render.TextureFormat.R16.UInt` @Value: '57'.
---| `render.TextureFormat.R16.SNorm` @Value: '58'.
---| `render.TextureFormat.R16.SInt` @Value: '59'.
---| `render.TextureFormat.R10G10B10A2.UNorm` @Value: '24'.
---| `render.TextureFormat.R10G10B10A2.UInt` @Value: '25'.
---| `render.TextureFormat.R11G11B10.Float` @Value: '26'.
---| `render.TextureFormat.R8G8B8A8.UNorm` @Value: '28'.
---| `render.TextureFormat.R8G8B8A8.UInt` @Value: '30'.
---| `render.TextureFormat.R8G8B8A8.SNorm` @Value: '31'.
---| `render.TextureFormat.R8G8B8A8.SInt` @Value: '32'.
---| `render.TextureFormat.R8G8.UNorm` @Value: '49'.
---| `render.TextureFormat.R8G8.UInt` @Value: '50'.
---| `render.TextureFormat.R8G8.SNorm` @Value: '51'.
---| `render.TextureFormat.R8G8.SInt` @Value: '52'.
---| `render.TextureFormat.R8.UNorm` @Value: '61'.
---| `render.TextureFormat.R8.UInt` @Value: '62'.
---| `render.TextureFormat.R8.SNorm` @Value: '63'.
---| `render.TextureFormat.R8.SInt` @Value: '64'.
---| `render.TextureFormat.R1.UNorm` @Value: '66'.
render.TextureFormat = {
  R32G32B32A32 = {Float = 2,UInt = 3,SInt = 4}, ---Value: {Float = 2,UInt = 3,SInt = 4}.
  R32G32B32 = {Float = 6,UInt = 7,SInt = 8}, ---Value: {Float = 6,UInt = 7,SInt = 8}.
  R32G32 = {Float = 16,UInt = 17,SInt = 18}, ---Value: {Float = 16,UInt = 17,SInt = 18}.
  R32 = {Float = 41,UInt = 42,SInt = 43}, ---Value: {Float = 41,UInt = 42,SInt = 43}.
  R16G16B16A16 = {Float = 10,UNorm = 11,UInt = 12,SNorm = 13,SInt = 14}, ---Value: {Float = 10,UNorm = 11,UInt = 12,SNorm = 13,SInt = 14}.
  R16G16 = {Float = 34,UNorm = 35,UInt = 36,SNorm = 37,SInt = 38}, ---Value: {Float = 34,UNorm = 35,UInt = 36,SNorm = 37,SInt = 38}.
  R16 = {Float = 54,UNorm = 56,UInt = 57,SNorm = 58,SInt = 59}, ---Value: {Float = 54,UNorm = 56,UInt = 57,SNorm = 58,SInt = 59}.
  R10G10B10A2 = {UNorm = 24,UInt = 25}, ---Value: {UNorm = 24,UInt = 25}.
  R11G11B10 = {Float = 26}, ---Value: {Float = 26}.
  R8G8B8A8 = {UNorm = 28,UInt = 30,SNorm = 31,SInt = 32}, ---Value: {UNorm = 28,UInt = 30,SNorm = 31,SInt = 32}.
  R8G8 = {UNorm = 49,UInt = 50,SNorm = 51,SInt = 52}, ---Value: {UNorm = 49,UInt = 50,SNorm = 51,SInt = 52}.
  R8 = {UNorm = 61,UInt = 62,SNorm = 63,SInt = 64}, ---Value: {UNorm = 61,UInt = 62,SNorm = 63,SInt = 64}.
  R1 = {UNorm = 66}, ---Value: {UNorm = 66}.
}

---@alias ac.LightType
---| `ac.LightType.Regular` @Value: 1.
---| `ac.LightType.Line` @Value: 2.
ac.LightType = {
  Regular = 1, ---Value: 1.
  Line = 2, ---Value: 2.
}

---@alias ui.CornerFlags
---| `ui.CornerFlags.None` @Value: 0.
---| `ui.CornerFlags.TopLeft` @Value: 1.
---| `ui.CornerFlags.TopRight` @Value: 2.
---| `ui.CornerFlags.BottomLeft` @Value: 4.
---| `ui.CornerFlags.BottomRight` @Value: 8.
---| `ui.CornerFlags.Top` @Value: 3.
---| `ui.CornerFlags.Bottom` @Value: 12.
---| `ui.CornerFlags.Left` @Value: 5.
---| `ui.CornerFlags.Right` @Value: 10.
---| `ui.CornerFlags.All` @Value: 15.
ui.CornerFlags = {
  None = 0, ---Value: 0.
  TopLeft = 1, ---Value: 1.
  TopRight = 2, ---Value: 2.
  BottomLeft = 4, ---Value: 4.
  BottomRight = 8, ---Value: 8.
  Top = 3, ---Value: 3.
  Bottom = 12, ---Value: 12.
  Left = 5, ---Value: 5.
  Right = 10, ---Value: 10.
  All = 15, ---Value: 15.
}

---@alias ui.Direction
---| `ui.Direction.None` @Value: -1.
---| `ui.Direction.Left` @Value: 0.
---| `ui.Direction.Right` @Value: 1.
---| `ui.Direction.Up` @Value: 2.
---| `ui.Direction.Down` @Value: 3.
ui.Direction = {
  None = -1, ---Value: -1.
  Left = 0, ---Value: 0.
  Right = 1, ---Value: 1.
  Up = 2, ---Value: 2.
  Down = 3, ---Value: 3.
}

---@alias ui.HoveredFlags
---| `ui.HoveredFlags.None` @Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
---| `ui.HoveredFlags.ChildWindows` @`ac.windowHovered()` only: Return true if any children of the window is hovered.
---| `ui.HoveredFlags.RootWindow` @`ac.windowHovered()` only: Test from root window (top most parent of the current hierarchy).
---| `ui.HoveredFlags.AnyWindow` @`ac.windowHovered()` only: Return true if any window is hovered.
---| `ui.HoveredFlags.AllowWhenBlockedByPopup` @Return true even if a popup window is normally blocking access to this item/window.
---| `ui.HoveredFlags.AllowWhenBlockedByActiveItem` @Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
---| `ui.HoveredFlags.AllowWhenOverlapped` @Return true even if the position is obstructed or overlapped by another window.
---| `ui.HoveredFlags.AllowWhenDisabled` @Return true even if the item is disabled.
---| `ui.HoveredFlags.RectOnly` @Combination of flags: AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped (use `bit.bor(ui.HoveredFlags.RectOnly, …)` to combine it with other flags safely).
---| `ui.HoveredFlags.RootAndChildWindows` @Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.HoveredFlags.RootAndChildWindows, …)` to combine it with other flags safely).
ui.HoveredFlags = {
  None = 0, ---Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
  ChildWindows = 1, ---`ac.windowHovered()` only: Return true if any children of the window is hovered.
  RootWindow = 2, ---`ac.windowHovered()` only: Test from root window (top most parent of the current hierarchy).
  AnyWindow = 4, ---`ac.windowHovered()` only: Return true if any window is hovered.
  AllowWhenBlockedByPopup = 8, ---Return true even if a popup window is normally blocking access to this item/window.
  AllowWhenBlockedByActiveItem = 32, ---Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
  AllowWhenOverlapped = 64, ---Return true even if the position is obstructed or overlapped by another window.
  AllowWhenDisabled = 128, ---Return true even if the item is disabled.
  RectOnly = 104, ---Combination of flags: AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped (use `bit.bor(ui.HoveredFlags.RectOnly, …)` to combine it with other flags safely).
  RootAndChildWindows = 3, ---Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.HoveredFlags.RootAndChildWindows, …)` to combine it with other flags safely).
}

---@alias ui.FocusedFlags
---| `ui.FocusedFlags.None` @Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
---| `ui.FocusedFlags.ChildWindows` @`ac.windowFocused()` only: Return true if any children of the window is hovered.
---| `ui.FocusedFlags.RootWindow` @`ac.windowFocused()` only: Test from root window (top most parent of the current hierarchy).
---| `ui.FocusedFlags.AnyWindow` @`ac.windowFocused()` only: Return true if any window is hovered.
---| `ui.FocusedFlags.RootAndChildWindows` @Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.FocusedFlags.RootAndChildWindows, …)` to combine it with other flags safely).
ui.FocusedFlags = {
  None = 0, ---Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
  ChildWindows = 1, ---`ac.windowFocused()` only: Return true if any children of the window is hovered.
  RootWindow = 2, ---`ac.windowFocused()` only: Test from root window (top most parent of the current hierarchy).
  AnyWindow = 4, ---`ac.windowFocused()` only: Return true if any window is hovered.
  RootAndChildWindows = 3, ---Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.FocusedFlags.RootAndChildWindows, …)` to combine it with other flags safely).
}

---@alias ui.MouseCursor
---| `ui.MouseCursor.None` @No cursor.
---| `ui.MouseCursor.Arrow` @Default arrow.
---| `ui.MouseCursor.TextInput` @When hovering over `ui.inputText()`, etc.
---| `ui.MouseCursor.ResizeAll` @Unused by default controls.
---| `ui.MouseCursor.ResizeNS` @When hovering over an horizontal border.
---| `ui.MouseCursor.ResizeEW` @When hovering over a vertical border or a column.
---| `ui.MouseCursor.ResizeNESW` @When hovering over the bottom-left corner of a window.
---| `ui.MouseCursor.ResizeNWSE` @When hovering over the bottom-right corner of a window.
---| `ui.MouseCursor.Hand` @Unused by default controls. Use for e.g. hyperlinks.
ui.MouseCursor = {
  None = -1, ---No cursor.
  Arrow = 0, ---Default arrow.
  TextInput = 1, ---When hovering over `ui.inputText()`, etc.
  ResizeAll = 2, ---Unused by default controls.
  ResizeNS = 3, ---When hovering over an horizontal border.
  ResizeEW = 4, ---When hovering over a vertical border or a column.
  ResizeNESW = 5, ---When hovering over the bottom-left corner of a window.
  ResizeNWSE = 6, ---When hovering over the bottom-right corner of a window.
  Hand = 7, ---Unused by default controls. Use for e.g. hyperlinks.
}

---@alias ui.MouseButton
---| `ui.MouseButton.Left` @Value: 0.
---| `ui.MouseButton.Right` @Value: 1.
---| `ui.MouseButton.Middle` @Value: 2.
---| `ui.MouseButton.Extra1` @Value: 3.
---| `ui.MouseButton.Extra2` @Value: 4.
ui.MouseButton = {
  Left = 0, ---Value: 0.
  Right = 1, ---Value: 1.
  Middle = 2, ---Value: 2.
  Extra1 = 3, ---Value: 3.
  Extra2 = 4, ---Value: 4.
}

---@alias ui.Font
---| `ui.Font.Small` @Value: 1.
---| `ui.Font.Tiny` @Value: 2.
---| `ui.Font.Monospace` @Value: 3.
---| `ui.Font.Main` @Value: 4.
---| `ui.Font.Italic` @Value: 5.
---| `ui.Font.Title` @Value: 6.
---| `ui.Font.Huge` @Value: 7.
ui.Font = {
  Small = 1, ---Value: 1.
  Tiny = 2, ---Value: 2.
  Monospace = 3, ---Value: 3.
  Main = 4, ---Value: 4.
  Italic = 5, ---Value: 5.
  Title = 6, ---Value: 6.
  Huge = 7, ---Value: 7.
}

---@alias ui.Alignment
---| `ui.Alignment.Start` @Value: -1.
---| `ui.Alignment.Center` @Value: 0.
---| `ui.Alignment.End` @Value: 1.
ui.Alignment = {
  Start = -1, ---Value: -1.
  Center = 0, ---Value: 0.
  End = 1, ---Value: 1.
}

---Special codes for keys with certain UI roles.
---@alias ui.Key
---| `ui.Key.Tab` @Value: 0.
---| `ui.Key.Left` @Value: 1.
---| `ui.Key.Right` @Value: 2.
---| `ui.Key.Up` @Value: 3.
---| `ui.Key.Down` @Value: 4.
---| `ui.Key.PageUp` @Value: 5.
---| `ui.Key.PageDown` @Value: 6.
---| `ui.Key.Home` @Value: 7.
---| `ui.Key.End` @Value: 8.
---| `ui.Key.Insert` @Value: 9.
---| `ui.Key.Delete` @Value: 10.
---| `ui.Key.Backspace` @Value: 11.
---| `ui.Key.Space` @Value: 12.
---| `ui.Key.Enter` @Value: 13.
---| `ui.Key.Escape` @Value: 14.
---| `ui.Key.KeyPadEnter` @Value: 15.
---| `ui.Key.A` @Value: 16.
---| `ui.Key.C` @Value: 17.
---| `ui.Key.D` @Value: 18.
---| `ui.Key.S` @Value: 19.
---| `ui.Key.V` @Value: 20.
---| `ui.Key.W` @Value: 21.
---| `ui.Key.X` @Value: 22.
---| `ui.Key.Y` @Value: 23.
---| `ui.Key.Z` @Value: 24.
ui.Key = {
  Tab = 0, ---Value: 0.
  Left = 1, ---Value: 1.
  Right = 2, ---Value: 2.
  Up = 3, ---Value: 3.
  Down = 4, ---Value: 4.
  PageUp = 5, ---Value: 5.
  PageDown = 6, ---Value: 6.
  Home = 7, ---Value: 7.
  End = 8, ---Value: 8.
  Insert = 9, ---Value: 9.
  Delete = 10, ---Value: 10.
  Backspace = 11, ---Value: 11.
  Space = 12, ---Value: 12.
  Enter = 13, ---Value: 13.
  Escape = 14, ---Value: 14.
  KeyPadEnter = 15, ---Value: 15.
  A = 16, ---Value: 16.
  C = 17, ---Value: 17.
  D = 18, ---Value: 18.
  S = 19, ---Value: 19.
  V = 20, ---Value: 20.
  W = 21, ---Value: 21.
  X = 22, ---Value: 22.
  Y = 23, ---Value: 23.
  Z = 24, ---Value: 24.
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ui.KeyIndex
---| `ui.KeyIndex.LeftButton` @Value: 1.
---| `ui.KeyIndex.RightButton` @Value: 2.
---| `ui.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.Tab` @Value: 9.
---| `ui.KeyIndex.Return` @Value: 13.
---| `ui.KeyIndex.Shift` @Value: 16.
---| `ui.KeyIndex.Control` @Value: 17.
---| `ui.KeyIndex.Menu` @Aka Alt button.
---| `ui.KeyIndex.Escape` @Value: 27.
---| `ui.KeyIndex.Accept` @Value: 30.
---| `ui.KeyIndex.Space` @Value: 32.
---| `ui.KeyIndex.End` @Value: 35.
---| `ui.KeyIndex.Home` @Value: 36.
---| `ui.KeyIndex.Left` @Arrow ←.
---| `ui.KeyIndex.Up` @Arrow ↑.
---| `ui.KeyIndex.Right` @Arrow →.
---| `ui.KeyIndex.Down` @Arrow ↓.
---| `ui.KeyIndex.Insert` @Value: 45.
---| `ui.KeyIndex.Delete` @Value: 46.
---| `ui.KeyIndex.LeftWin` @Value: 91.
---| `ui.KeyIndex.RightWin` @Value: 92.
---| `ui.KeyIndex.NumPad0` @Value: 96.
---| `ui.KeyIndex.NumPad1` @Value: 97.
---| `ui.KeyIndex.NumPad2` @Value: 98.
---| `ui.KeyIndex.NumPad3` @Value: 99.
---| `ui.KeyIndex.NumPad4` @Value: 100.
---| `ui.KeyIndex.NumPad5` @Value: 101.
---| `ui.KeyIndex.NumPad6` @Value: 102.
---| `ui.KeyIndex.NumPad7` @Value: 103.
---| `ui.KeyIndex.NumPad8` @Value: 104.
---| `ui.KeyIndex.NumPad9` @Value: 105.
---| `ui.KeyIndex.Multiply` @Value: 106.
---| `ui.KeyIndex.Add` @Value: 107.
---| `ui.KeyIndex.Separator` @Value: 108.
---| `ui.KeyIndex.Subtract` @Value: 109.
---| `ui.KeyIndex.Decimal` @Value: 110.
---| `ui.KeyIndex.Divide` @Value: 111.
---| `ui.KeyIndex.F1` @Value: 112.
---| `ui.KeyIndex.F2` @Value: 113.
---| `ui.KeyIndex.F3` @Value: 114.
---| `ui.KeyIndex.F4` @Value: 115.
---| `ui.KeyIndex.F5` @Value: 116.
---| `ui.KeyIndex.F6` @Value: 117.
---| `ui.KeyIndex.F7` @Value: 118.
---| `ui.KeyIndex.F8` @Value: 119.
---| `ui.KeyIndex.F9` @Value: 120.
---| `ui.KeyIndex.F10` @Value: 121.
---| `ui.KeyIndex.F11` @Value: 122.
---| `ui.KeyIndex.F12` @Value: 123.
---| `ui.KeyIndex.NumLock` @Value: 144.
---| `ui.KeyIndex.Scroll` @Value: 145.
---| `ui.KeyIndex.OemNecEqual` @“.
---| `ui.KeyIndex.LeftShift` @Value: 160.
---| `ui.KeyIndex.RightShift` @Value: 161.
---| `ui.KeyIndex.LeftControl` @Value: 162.
---| `ui.KeyIndex.RightControl` @Value: 163.
---| `ui.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ui.KeyIndex.RightMenu` @Aka right Alt button.
---| `ui.KeyIndex.Oem1` @“;:” for US.
---| `ui.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ui.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ui.KeyIndex.D0` @Digit 0.
---| `ui.KeyIndex.D1` @Digit 1.
---| `ui.KeyIndex.D2` @Digit 2.
---| `ui.KeyIndex.D3` @Digit 3.
---| `ui.KeyIndex.D4` @Digit 4.
---| `ui.KeyIndex.D5` @Digit 5.
---| `ui.KeyIndex.D6` @Digit 6.
---| `ui.KeyIndex.D7` @Digit 7.
---| `ui.KeyIndex.D8` @Digit 8.
---| `ui.KeyIndex.D9` @Digit 9.
---| `ui.KeyIndex.A` @Letter A.
---| `ui.KeyIndex.B` @Letter B.
---| `ui.KeyIndex.C` @Letter C.
---| `ui.KeyIndex.D` @Letter D.
---| `ui.KeyIndex.E` @Letter E.
---| `ui.KeyIndex.F` @Letter F.
---| `ui.KeyIndex.G` @Letter G.
---| `ui.KeyIndex.H` @Letter H.
---| `ui.KeyIndex.I` @Letter I.
---| `ui.KeyIndex.J` @Letter J.
---| `ui.KeyIndex.K` @Letter K.
---| `ui.KeyIndex.L` @Letter L.
---| `ui.KeyIndex.M` @Letter M.
---| `ui.KeyIndex.N` @Letter N.
---| `ui.KeyIndex.O` @Letter O.
---| `ui.KeyIndex.P` @Letter P.
---| `ui.KeyIndex.Q` @Letter Q.
---| `ui.KeyIndex.R` @Letter R.
---| `ui.KeyIndex.S` @Letter S.
---| `ui.KeyIndex.T` @Letter T.
---| `ui.KeyIndex.U` @Letter U.
---| `ui.KeyIndex.V` @Letter V.
---| `ui.KeyIndex.W` @Letter W.
---| `ui.KeyIndex.X` @Letter X.
---| `ui.KeyIndex.Y` @Letter Y.
---| `ui.KeyIndex.Z` @Letter Z.
ui.KeyIndex = {
  LeftButton = 1, ---Value: 1.
  RightButton = 2, ---Value: 2.
  Cancel = 3, ---Value: 3.
  MiddleButton = 4, ---Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---Not contiguous with LeftButton and RightButton.
  Back = 8, ---Value: 8.
  Tab = 9, ---Value: 9.
  Clear = 12, ---Value: 12.
  Return = 13, ---Value: 13.
  Shift = 16, ---Value: 16.
  Control = 17, ---Value: 17.
  Menu = 18, ---Aka Alt button.
  Pause = 19, ---Value: 19.
  Capital = 20, ---Value: 20.
  Kana = 21, ---Value: 21.
  Hangeul = 21, ---Old name - should be here for compatibility.
  Hangul = 21, ---Value: 21.
  Junja = 23, ---Value: 23.
  Final = 24, ---Value: 24.
  Hanja = 25, ---Value: 25.
  Kanji = 25, ---Value: 25.
  Escape = 27, ---Value: 27.
  Convert = 28, ---Value: 28.
  NonConvert = 29, ---Value: 29.
  Accept = 30, ---Value: 30.
  ModeChange = 31, ---Value: 31.
  Space = 32, ---Value: 32.
  Prior = 33, ---Value: 33.
  Next = 34, ---Value: 34.
  End = 35, ---Value: 35.
  Home = 36, ---Value: 36.
  Left = 37, ---Arrow ←.
  Up = 38, ---Arrow ↑.
  Right = 39, ---Arrow →.
  Down = 40, ---Arrow ↓.
  Select = 41, ---Value: 41.
  Print = 42, ---Value: 42.
  Execute = 43, ---Value: 43.
  Snapshot = 44, ---Value: 44.
  Insert = 45, ---Value: 45.
  Delete = 46, ---Value: 46.
  Help = 47, ---Value: 47.
  LeftWin = 91, ---Value: 91.
  RightWin = 92, ---Value: 92.
  Apps = 93, ---Value: 93.
  Sleep = 95, ---Value: 95.
  NumPad0 = 96, ---Value: 96.
  NumPad1 = 97, ---Value: 97.
  NumPad2 = 98, ---Value: 98.
  NumPad3 = 99, ---Value: 99.
  NumPad4 = 100, ---Value: 100.
  NumPad5 = 101, ---Value: 101.
  NumPad6 = 102, ---Value: 102.
  NumPad7 = 103, ---Value: 103.
  NumPad8 = 104, ---Value: 104.
  NumPad9 = 105, ---Value: 105.
  Multiply = 106, ---Value: 106.
  Add = 107, ---Value: 107.
  Separator = 108, ---Value: 108.
  Subtract = 109, ---Value: 109.
  Decimal = 110, ---Value: 110.
  Divide = 111, ---Value: 111.
  F1 = 112, ---Value: 112.
  F2 = 113, ---Value: 113.
  F3 = 114, ---Value: 114.
  F4 = 115, ---Value: 115.
  F5 = 116, ---Value: 116.
  F6 = 117, ---Value: 117.
  F7 = 118, ---Value: 118.
  F8 = 119, ---Value: 119.
  F9 = 120, ---Value: 120.
  F10 = 121, ---Value: 121.
  F11 = 122, ---Value: 122.
  F12 = 123, ---Value: 123.
  F13 = 124, ---Value: 124.
  F14 = 125, ---Value: 125.
  F15 = 126, ---Value: 126.
  F16 = 127, ---Value: 127.
  F17 = 128, ---Value: 128.
  F18 = 129, ---Value: 129.
  F19 = 130, ---Value: 130.
  F20 = 131, ---Value: 131.
  F21 = 132, ---Value: 132.
  F22 = 133, ---Value: 133.
  F23 = 134, ---Value: 134.
  F24 = 135, ---Value: 135.
  NavigationView = 136, ---Reserved.
  NavigationMenu = 137, ---Reserved.
  NavigationUp = 138, ---Reserved.
  NavigationDown = 139, ---Reserved.
  NavigationLeft = 140, ---Reserved.
  NavigationRight = 141, ---Reserved.
  NavigationAccept = 142, ---Reserved.
  NavigationCancel = 143, ---Reserved.
  NumLock = 144, ---Value: 144.
  Scroll = 145, ---Value: 145.
  OemNecEqual = 146, ---“.
  OemFjJisho = 146, ---“Dictionary” key.
  OemFjMasshou = 147, ---“Unregister word” key.
  OemFjTouroku = 148, ---“Register word” key.
  OemFjLoya = 149, ---“Left OYAYUBI” key.
  OemFjRoya = 150, ---“Right OYAYUBI” key.
  LeftShift = 160, ---Value: 160.
  RightShift = 161, ---Value: 161.
  LeftControl = 162, ---Value: 162.
  RightControl = 163, ---Value: 163.
  LeftMenu = 164, ---Aka left Alt button.
  RightMenu = 165, ---Aka right Alt button.
  BrowserBack = 166, ---Value: 166.
  BrowserForward = 167, ---Value: 167.
  BrowserRefresh = 168, ---Value: 168.
  BrowserStop = 169, ---Value: 169.
  BrowserSearch = 170, ---Value: 170.
  BrowserFavorites = 171, ---Value: 171.
  BrowserHome = 172, ---Value: 172.
  VolumeMute = 173, ---Value: 173.
  VolumeDown = 174, ---Value: 174.
  VolumeUp = 175, ---Value: 175.
  MediaNextTrack = 176, ---Value: 176.
  MediaPrevTrack = 177, ---Value: 177.
  MediaStop = 178, ---Value: 178.
  MediaPlayPause = 179, ---Value: 179.
  LaunchMail = 180, ---Value: 180.
  LaunchMediaSelect = 181, ---Value: 181.
  LaunchApp1 = 182, ---Value: 182.
  LaunchApp2 = 183, ---Value: 183.
  Oem1 = 186, ---“;:” for US.
  OemPlus = 187, ---“+” any country.
  OemComma = 188, ---“,” any country.
  OemMinus = 189, ---“-” any country.
  OemPeriod = 190, ---“.” any country.
  Oem2 = 191, ---“/?” for US.
  Oem3 = 192, ---“`~” for US.
  GamepadA = 195, ---Reserved.
  GamepadB = 196, ---Reserved.
  GamepadX = 197, ---Reserved.
  GamepadY = 198, ---Reserved.
  GamepadRightShoulder = 199, ---Reserved.
  GamepadLeftShoulder = 200, ---Reserved.
  GamepadLeftTrigger = 201, ---Reserved.
  GamepadRightTrigger = 202, ---Reserved.
  GamepadDpadUp = 203, ---Reserved.
  GamepadDpadDown = 204, ---Reserved.
  GamepadDpadLeft = 205, ---Reserved.
  GamepadDpadRight = 206, ---Reserved.
  GamepadMenu = 207, ---Reserved.
  GamepadView = 208, ---Reserved.
  GamepadLeftThumbstickButton = 209, ---Reserved.
  GamepadRightThumbstickButton = 210, ---Reserved.
  GamepadLeftThumbstickUp = 211, ---Reserved.
  GamepadLeftThumbstickDown = 212, ---Reserved.
  GamepadLeftThumbstickRight = 213, ---Reserved.
  GamepadLeftThumbstickLeft = 214, ---Reserved.
  GamepadRightThumbstickUp = 215, ---Reserved.
  GamepadRightThumbstickDown = 216, ---Reserved.
  GamepadRightThumbstickRight = 217, ---Reserved.
  GamepadRightThumbstickLeft = 218, ---Reserved.
  SquareOpenBracket = 219, ---Value: 219.
  SquareCloseBracket = 221, ---Value: 221.
  D0 = 48, ---Digit 0.
  D1 = 49, ---Digit 1.
  D2 = 50, ---Digit 2.
  D3 = 51, ---Digit 3.
  D4 = 52, ---Digit 4.
  D5 = 53, ---Digit 5.
  D6 = 54, ---Digit 6.
  D7 = 55, ---Digit 7.
  D8 = 56, ---Digit 8.
  D9 = 57, ---Digit 9.
  A = 65, ---Letter A.
  B = 66, ---Letter B.
  C = 67, ---Letter C.
  D = 68, ---Letter D.
  E = 69, ---Letter E.
  F = 70, ---Letter F.
  G = 71, ---Letter G.
  H = 72, ---Letter H.
  I = 73, ---Letter I.
  J = 74, ---Letter J.
  K = 75, ---Letter K.
  L = 76, ---Letter L.
  M = 77, ---Letter M.
  N = 78, ---Letter N.
  O = 79, ---Letter O.
  P = 80, ---Letter P.
  Q = 81, ---Letter Q.
  R = 82, ---Letter R.
  S = 83, ---Letter S.
  T = 84, ---Letter T.
  U = 85, ---Letter U.
  V = 86, ---Letter V.
  W = 87, ---Letter W.
  X = 88, ---Letter X.
  Y = 89, ---Letter Y.
  Z = 90, ---Letter Z.
}

---@alias ui.StyleVar
---| `ui.StyleVar.Alpha` @Value: 0.
---| `ui.StyleVar.WindowPadding` @Value: 1.
---| `ui.StyleVar.WindowRounding` @Value: 2.
---| `ui.StyleVar.WindowBorderSize` @Value: 3.
---| `ui.StyleVar.WindowMinSize` @Value: 4.
---| `ui.StyleVar.WindowTitleAlign` @Value: 5.
---| `ui.StyleVar.ChildRounding` @Value: 6.
---| `ui.StyleVar.ChildBorderSize` @Value: 7.
---| `ui.StyleVar.PopupRounding` @Value: 8.
---| `ui.StyleVar.PopupBorderSize` @Value: 9.
---| `ui.StyleVar.FramePadding` @Value: 10.
---| `ui.StyleVar.FrameRounding` @Value: 11.
---| `ui.StyleVar.FrameBorderSize` @Value: 12.
---| `ui.StyleVar.ItemSpacing` @Value: 13.
---| `ui.StyleVar.ItemInnerSpacing` @Value: 14.
---| `ui.StyleVar.IndentSpacing` @Value: 15.
---| `ui.StyleVar.ScrollbarSize` @Value: 16.
---| `ui.StyleVar.ScrollbarRounding` @Value: 17.
---| `ui.StyleVar.GrabMinSize` @Value: 18.
---| `ui.StyleVar.GrabRounding` @Value: 19.
---| `ui.StyleVar.TabRounding` @Value: 20.
---| `ui.StyleVar.ButtonTextAlign` @Value: 21.
---| `ui.StyleVar.SelectableTextAlign` @Value: 22.
---| `ui.StyleVar.SelectablePadding` @Value: 23.
ui.StyleVar = {
  Alpha = 0, ---Value: 0.
  WindowPadding = 1, ---Value: 1.
  WindowRounding = 2, ---Value: 2.
  WindowBorderSize = 3, ---Value: 3.
  WindowMinSize = 4, ---Value: 4.
  WindowTitleAlign = 5, ---Value: 5.
  ChildRounding = 6, ---Value: 6.
  ChildBorderSize = 7, ---Value: 7.
  PopupRounding = 8, ---Value: 8.
  PopupBorderSize = 9, ---Value: 9.
  FramePadding = 10, ---Value: 10.
  FrameRounding = 11, ---Value: 11.
  FrameBorderSize = 12, ---Value: 12.
  ItemSpacing = 13, ---Value: 13.
  ItemInnerSpacing = 14, ---Value: 14.
  IndentSpacing = 15, ---Value: 15.
  ScrollbarSize = 16, ---Value: 16.
  ScrollbarRounding = 17, ---Value: 17.
  GrabMinSize = 18, ---Value: 18.
  GrabRounding = 19, ---Value: 19.
  TabRounding = 20, ---Value: 20.
  ButtonTextAlign = 21, ---Value: 21.
  SelectableTextAlign = 22, ---Value: 22.
  SelectablePadding = 23, ---Value: 23.
}

---@alias ui.StyleColor
---| `ui.StyleColor.Text` @Value: 0.
---| `ui.StyleColor.TextDisabled` @Value: 1.
---| `ui.StyleColor.WindowBg` @Value: 2.
---| `ui.StyleColor.ChildBg` @Value: 3.
---| `ui.StyleColor.PopupBg` @Value: 4.
---| `ui.StyleColor.Border` @Value: 5.
---| `ui.StyleColor.BorderShadow` @Value: 6.
---| `ui.StyleColor.FrameBg` @Value: 7.
---| `ui.StyleColor.FrameBgHovered` @Value: 8.
---| `ui.StyleColor.FrameBgActive` @Value: 9.
---| `ui.StyleColor.TitleBg` @Value: 10.
---| `ui.StyleColor.TitleBgActive` @Value: 11.
---| `ui.StyleColor.TitleBgCollapsed` @Value: 12.
---| `ui.StyleColor.MenuBarBg` @Value: 13.
---| `ui.StyleColor.ScrollbarBg` @Value: 14.
---| `ui.StyleColor.ScrollbarGrab` @Value: 15.
---| `ui.StyleColor.ScrollbarGrabHovered` @Value: 16.
---| `ui.StyleColor.ScrollbarGrabActive` @Value: 17.
---| `ui.StyleColor.CheckMark` @Value: 18.
---| `ui.StyleColor.SliderGrab` @Value: 19.
---| `ui.StyleColor.SliderGrabActive` @Value: 20.
---| `ui.StyleColor.Button` @Value: 21.
---| `ui.StyleColor.ButtonHovered` @Value: 22.
---| `ui.StyleColor.ButtonActive` @Value: 23.
---| `ui.StyleColor.Header` @Value: 24.
---| `ui.StyleColor.HeaderHovered` @Value: 25.
---| `ui.StyleColor.HeaderActive` @Value: 26.
---| `ui.StyleColor.Separator` @Value: 27.
---| `ui.StyleColor.SeparatorHovered` @Value: 28.
---| `ui.StyleColor.SeparatorActive` @Value: 29.
---| `ui.StyleColor.ResizeGrip` @Value: 30.
---| `ui.StyleColor.ResizeGripHovered` @Value: 31.
---| `ui.StyleColor.ResizeGripActive` @Value: 32.
---| `ui.StyleColor.Tab` @Value: 33.
---| `ui.StyleColor.TabHovered` @Value: 34.
---| `ui.StyleColor.TabActive` @Value: 35.
---| `ui.StyleColor.TabUnfocused` @Value: 36.
---| `ui.StyleColor.TabUnfocusedActive` @Value: 37.
---| `ui.StyleColor.PlotLines` @Value: 38.
---| `ui.StyleColor.PlotLinesHovered` @Value: 39.
---| `ui.StyleColor.PlotHistogram` @Value: 40.
---| `ui.StyleColor.PlotHistogramHovered` @Value: 41.
---| `ui.StyleColor.TextSelectedBg` @Value: 42.
---| `ui.StyleColor.DragDropTarget` @Value: 43.
---| `ui.StyleColor.NavHighlight` @Value: 44.
---| `ui.StyleColor.NavWindowingHighlight` @Value: 45.
---| `ui.StyleColor.NavWindowingDimBg` @Value: 46.
---| `ui.StyleColor.ModalWindowDimBg` @Value: 47.
---| `ui.StyleColor.TextHovered` @Value: 48.
---| `ui.StyleColor.TextActive` @Value: 49.
ui.StyleColor = {
  Text = 0, ---Value: 0.
  TextDisabled = 1, ---Value: 1.
  WindowBg = 2, ---Value: 2.
  ChildBg = 3, ---Value: 3.
  PopupBg = 4, ---Value: 4.
  Border = 5, ---Value: 5.
  BorderShadow = 6, ---Value: 6.
  FrameBg = 7, ---Value: 7.
  FrameBgHovered = 8, ---Value: 8.
  FrameBgActive = 9, ---Value: 9.
  TitleBg = 10, ---Value: 10.
  TitleBgActive = 11, ---Value: 11.
  TitleBgCollapsed = 12, ---Value: 12.
  MenuBarBg = 13, ---Value: 13.
  ScrollbarBg = 14, ---Value: 14.
  ScrollbarGrab = 15, ---Value: 15.
  ScrollbarGrabHovered = 16, ---Value: 16.
  ScrollbarGrabActive = 17, ---Value: 17.
  CheckMark = 18, ---Value: 18.
  SliderGrab = 19, ---Value: 19.
  SliderGrabActive = 20, ---Value: 20.
  Button = 21, ---Value: 21.
  ButtonHovered = 22, ---Value: 22.
  ButtonActive = 23, ---Value: 23.
  Header = 24, ---Value: 24.
  HeaderHovered = 25, ---Value: 25.
  HeaderActive = 26, ---Value: 26.
  Separator = 27, ---Value: 27.
  SeparatorHovered = 28, ---Value: 28.
  SeparatorActive = 29, ---Value: 29.
  ResizeGrip = 30, ---Value: 30.
  ResizeGripHovered = 31, ---Value: 31.
  ResizeGripActive = 32, ---Value: 32.
  Tab = 33, ---Value: 33.
  TabHovered = 34, ---Value: 34.
  TabActive = 35, ---Value: 35.
  TabUnfocused = 36, ---Value: 36.
  TabUnfocusedActive = 37, ---Value: 37.
  PlotLines = 38, ---Value: 38.
  PlotLinesHovered = 39, ---Value: 39.
  PlotHistogram = 40, ---Value: 40.
  PlotHistogramHovered = 41, ---Value: 41.
  TextSelectedBg = 42, ---Value: 42.
  DragDropTarget = 43, ---Value: 43.
  NavHighlight = 44, ---Value: 44.
  NavWindowingHighlight = 45, ---Value: 45.
  NavWindowingDimBg = 46, ---Value: 46.
  ModalWindowDimBg = 47, ---Value: 47.
  TextHovered = 48, ---Value: 48.
  TextActive = 49, ---Value: 49.
}

---@alias ui.Icons
---| `ui.Icons.Apps` @![Icon](https://acstuff.ru/images/icons_24/apps.png)
---| `ui.Icons.ArrowDown` @![Icon](https://acstuff.ru/images/icons_24/arrow_down.png)
---| `ui.Icons.ArrowLeft` @![Icon](https://acstuff.ru/images/icons_24/arrow_left.png)
---| `ui.Icons.ArrowRight` @![Icon](https://acstuff.ru/images/icons_24/arrow_right.png)
---| `ui.Icons.ArrowUp` @![Icon](https://acstuff.ru/images/icons_24/arrow_up.png)
---| `ui.Icons.Back` @![Icon](https://acstuff.ru/images/icons_24/back.png)
---| `ui.Icons.Backspace` @![Icon](https://acstuff.ru/images/icons_24/backspace.png)
---| `ui.Icons.Ballast` @![Icon](https://acstuff.ru/images/icons_24/ballast.png)
---| `ui.Icons.Ban` @![Icon](https://acstuff.ru/images/icons_24/ban.png)
---| `ui.Icons.Befriend` @![Icon](https://acstuff.ru/images/icons_24/befriend.png)
---| `ui.Icons.Bell` @![Icon](https://acstuff.ru/images/icons_24/bell.png)
---| `ui.Icons.Bluetooth` @![Icon](https://acstuff.ru/images/icons_24/bluetooth.png)
---| `ui.Icons.Bug` @![Icon](https://acstuff.ru/images/icons_24/bug.png)
---| `ui.Icons.Bulb` @![Icon](https://acstuff.ru/images/icons_24/bulb.png)
---| `ui.Icons.Burn` @![Icon](https://acstuff.ru/images/icons_24/burn.png)
---| `ui.Icons.CallBluetooth` @![Icon](https://acstuff.ru/images/icons_24/call_bluetooth.png)
---| `ui.Icons.Call` @![Icon](https://acstuff.ru/images/icons_24/call.png)
---| `ui.Icons.Camera` @![Icon](https://acstuff.ru/images/icons_24/camera.png)
---| `ui.Icons.Cancel` @![Icon](https://acstuff.ru/images/icons_24/cancel.png)
---| `ui.Icons.CarFront` @![Icon](https://acstuff.ru/images/icons_24/car_front.png)
---| `ui.Icons.Clip` @![Icon](https://acstuff.ru/images/icons_24/clip.png)
---| `ui.Icons.Clock` @![Icon](https://acstuff.ru/images/icons_24/clock.png)
---| `ui.Icons.Compass` @![Icon](https://acstuff.ru/images/icons_24/compass.png)
---| `ui.Icons.Confirm` @![Icon](https://acstuff.ru/images/icons_24/confirm.png)
---| `ui.Icons.Copy` @![Icon](https://acstuff.ru/images/icons_24/copy.png)
---| `ui.Icons.Crosshair` @![Icon](https://acstuff.ru/images/icons_24/crosshair.png)
---| `ui.Icons.Delete` @![Icon](https://acstuff.ru/images/icons_24/delete.png)
---| `ui.Icons.Down` @![Icon](https://acstuff.ru/images/icons_24/down.png)
---| `ui.Icons.Download` @![Icon](https://acstuff.ru/images/icons_24/download.png)
---| `ui.Icons.Earth` @![Icon](https://acstuff.ru/images/icons_24/earth.png)
---| `ui.Icons.Edit` @![Icon](https://acstuff.ru/images/icons_24/edit.png)
---| `ui.Icons.Ellipsis` @![Icon](https://acstuff.ru/images/icons_24/ellipsis.png)
---| `ui.Icons.Enter` @![Icon](https://acstuff.ru/images/icons_24/enter.png)
---| `ui.Icons.Eye` @![Icon](https://acstuff.ru/images/icons_24/eye.png)
---| `ui.Icons.FastForward` @![Icon](https://acstuff.ru/images/icons_24/fast_forward.png)
---| `ui.Icons.File` @![Icon](https://acstuff.ru/images/icons_24/file.png)
---| `ui.Icons.Finish` @![Icon](https://acstuff.ru/images/icons_24/finish.png)
---| `ui.Icons.FM` @![Icon](https://acstuff.ru/images/icons_24/fm.png)
---| `ui.Icons.Folder` @![Icon](https://acstuff.ru/images/icons_24/folder.png)
---| `ui.Icons.Fuel` @![Icon](https://acstuff.ru/images/icons_24/fuel.png)
---| `ui.Icons.Global` @![Icon](https://acstuff.ru/images/icons_24/global.png)
---| `ui.Icons.GlowThick` @![Icon](https://acstuff.ru/images/icons_24/glow_thick.png)
---| `ui.Icons.Glow` @![Icon](https://acstuff.ru/images/icons_24/glow.png)
---| `ui.Icons.GPS` @![Icon](https://acstuff.ru/images/icons_24/gps.png)
---| `ui.Icons.Group` @![Icon](https://acstuff.ru/images/icons_24/group.png)
---| `ui.Icons.Hammer` @![Icon](https://acstuff.ru/images/icons_24/hammer.png)
---| `ui.Icons.Hide` @![Icon](https://acstuff.ru/images/icons_24/hide.png)
---| `ui.Icons.Horizontal` @![Icon](https://acstuff.ru/images/icons_24/horizontal.png)
---| `ui.Icons.Info` @![Icon](https://acstuff.ru/images/icons_24/info.png)
---| `ui.Icons.Key` @![Icon](https://acstuff.ru/images/icons_24/key.png)
---| `ui.Icons.Kick` @![Icon](https://acstuff.ru/images/icons_24/kick.png)
---| `ui.Icons.Landscape` @![Icon](https://acstuff.ru/images/icons_24/landscape.png)
---| `ui.Icons.Leaderboard` @![Icon](https://acstuff.ru/images/icons_24/leaderboard.png)
---| `ui.Icons.Leave` @![Icon](https://acstuff.ru/images/icons_24/leave.png)
---| `ui.Icons.Lens` @![Icon](https://acstuff.ru/images/icons_24/lens.png)
---| `ui.Icons.Loading` @![Icon](https://acstuff.ru/images/icons_24/loading.png)
---| `ui.Icons.Location` @![Icon](https://acstuff.ru/images/icons_24/location.png)
---| `ui.Icons.Lua` @![Icon](https://acstuff.ru/images/icons_24/lua.png)
---| `ui.Icons.Map` @![Icon](https://acstuff.ru/images/icons_24/map.png)
---| `ui.Icons.Menu` @![Icon](https://acstuff.ru/images/icons_24/menu.png)
---| `ui.Icons.Minus` @![Icon](https://acstuff.ru/images/icons_24/minus.png)
---| `ui.Icons.Monitor` @![Icon](https://acstuff.ru/images/icons_24/monitor.png)
---| `ui.Icons.Music` @![Icon](https://acstuff.ru/images/icons_24/music.png)
---| `ui.Icons.Mute` @![Icon](https://acstuff.ru/images/icons_24/mute.png)
---| `ui.Icons.Navigation` @![Icon](https://acstuff.ru/images/icons_24/navigation.png)
---| `ui.Icons.Next` @![Icon](https://acstuff.ru/images/icons_24/next.png)
---| `ui.Icons.NotificationsAny` @![Icon](https://acstuff.ru/images/icons_24/notifications_any.png)
---| `ui.Icons.Notifications` @![Icon](https://acstuff.ru/images/icons_24/notifications.png)
---| `ui.Icons.Palette` @![Icon](https://acstuff.ru/images/icons_24/palette.png)
---| `ui.Icons.Paste` @![Icon](https://acstuff.ru/images/icons_24/paste.png)
---| `ui.Icons.Pause` @![Icon](https://acstuff.ru/images/icons_24/pause.png)
---| `ui.Icons.Pedals` @![Icon](https://acstuff.ru/images/icons_24/pedals.png)
---| `ui.Icons.Pin` @![Icon](https://acstuff.ru/images/icons_24/pin.png)
---| `ui.Icons.PitStop` @![Icon](https://acstuff.ru/images/icons_24/pit_stop.png)
---| `ui.Icons.Play` @![Icon](https://acstuff.ru/images/icons_24/play.png)
---| `ui.Icons.Plus` @![Icon](https://acstuff.ru/images/icons_24/plus.png)
---| `ui.Icons.Preview` @![Icon](https://acstuff.ru/images/icons_24/preview.png)
---| `ui.Icons.Process` @![Icon](https://acstuff.ru/images/icons_24/process.png)
---| `ui.Icons.Python` @![Icon](https://acstuff.ru/images/icons_24/python.png)
---| `ui.Icons.QuestionSign` @![Icon](https://acstuff.ru/images/icons_24/question_sign.png)
---| `ui.Icons.Referee` @![Icon](https://acstuff.ru/images/icons_24/referee.png)
---| `ui.Icons.Repair` @![Icon](https://acstuff.ru/images/icons_24/repair.png)
---| `ui.Icons.RestartWarning` @![Icon](https://acstuff.ru/images/icons_24/restart_warning.png)
---| `ui.Icons.Restart` @![Icon](https://acstuff.ru/images/icons_24/restart.png)
---| `ui.Icons.Restrictor` @![Icon](https://acstuff.ru/images/icons_24/restrictor.png)
---| `ui.Icons.Resume` @![Icon](https://acstuff.ru/images/icons_24/resume.png)
---| `ui.Icons.Rewind` @![Icon](https://acstuff.ru/images/icons_24/rewind.png)
---| `ui.Icons.Road` @![Icon](https://acstuff.ru/images/icons_24/road.png)
---| `ui.Icons.Rubber` @![Icon](https://acstuff.ru/images/icons_24/rubber.png)
---| `ui.Icons.SatelliteDishLow` @![Icon](https://acstuff.ru/images/icons_24/satellite_dish_low.png)
---| `ui.Icons.SatelliteDishNone` @![Icon](https://acstuff.ru/images/icons_24/satellite_dish_none.png)
---| `ui.Icons.SatelliteDish` @![Icon](https://acstuff.ru/images/icons_24/satellite_dish.png)
---| `ui.Icons.Save` @![Icon](https://acstuff.ru/images/icons_24/save.png)
---| `ui.Icons.Sea` @![Icon](https://acstuff.ru/images/icons_24/sea.png)
---| `ui.Icons.Search` @![Icon](https://acstuff.ru/images/icons_24/search.png)
---| `ui.Icons.Send` @![Icon](https://acstuff.ru/images/icons_24/send.png)
---| `ui.Icons.Settings` @![Icon](https://acstuff.ru/images/icons_24/settings.png)
---| `ui.Icons.ShiftActive` @![Icon](https://acstuff.ru/images/icons_24/shift_active.png)
---| `ui.Icons.Shift` @![Icon](https://acstuff.ru/images/icons_24/shift.png)
---| `ui.Icons.Skip` @![Icon](https://acstuff.ru/images/icons_24/skip.png)
---| `ui.Icons.Sleep` @![Icon](https://acstuff.ru/images/icons_24/sleep.png)
---| `ui.Icons.Sliders` @![Icon](https://acstuff.ru/images/icons_24/sliders.png)
---| `ui.Icons.SlowMotion` @![Icon](https://acstuff.ru/images/icons_24/slow_motion.png)
---| `ui.Icons.Smile` @![Icon](https://acstuff.ru/images/icons_24/smile.png)
---| `ui.Icons.Speedometer` @![Icon](https://acstuff.ru/images/icons_24/speedometer.png)
---| `ui.Icons.Spotify` @![Icon](https://acstuff.ru/images/icons_24/spotify.png)
---| `ui.Icons.StarEmpty` @![Icon](https://acstuff.ru/images/icons_24/star_empty.png)
---| `ui.Icons.StarFull` @![Icon](https://acstuff.ru/images/icons_24/star_full.png)
---| `ui.Icons.StarHalf` @![Icon](https://acstuff.ru/images/icons_24/star_half.png)
---| `ui.Icons.Start` @![Icon](https://acstuff.ru/images/icons_24/start.png)
---| `ui.Icons.Stay` @![Icon](https://acstuff.ru/images/icons_24/stay.png)
---| `ui.Icons.SteeringWheel` @![Icon](https://acstuff.ru/images/icons_24/steering_wheel.png)
---| `ui.Icons.Stopwatch` @![Icon](https://acstuff.ru/images/icons_24/stopwatch.png)
---| `ui.Icons.Tag` @![Icon](https://acstuff.ru/images/icons_24/tag.png)
---| `ui.Icons.Target` @![Icon](https://acstuff.ru/images/icons_24/target.png)
---| `ui.Icons.Teleport` @![Icon](https://acstuff.ru/images/icons_24/teleport.png)
---| `ui.Icons.Thermometer` @![Icon](https://acstuff.ru/images/icons_24/thermometer.png)
---| `ui.Icons.TrafficLight` @![Icon](https://acstuff.ru/images/icons_24/traffic_light.png)
---| `ui.Icons.Transmission` @![Icon](https://acstuff.ru/images/icons_24/transmission.png)
---| `ui.Icons.Undo` @![Icon](https://acstuff.ru/images/icons_24/undo.png)
---| `ui.Icons.Up` @![Icon](https://acstuff.ru/images/icons_24/up.png)
---| `ui.Icons.Verified` @![Icon](https://acstuff.ru/images/icons_24/verified.png)
---| `ui.Icons.VideoCamera` @![Icon](https://acstuff.ru/images/icons_24/video_camera.png)
---| `ui.Icons.VolumeHigh` @![Icon](https://acstuff.ru/images/icons_24/volume_high.png)
---| `ui.Icons.VolumeLow` @![Icon](https://acstuff.ru/images/icons_24/volume_low.png)
---| `ui.Icons.VolumeMedium` @![Icon](https://acstuff.ru/images/icons_24/volume_medium.png)
---| `ui.Icons.Warning` @![Icon](https://acstuff.ru/images/icons_24/warning.png)
---| `ui.Icons.WeatherClear` @![Icon](https://acstuff.ru/images/icons_24/weather_clear.png)
---| `ui.Icons.WeatherCold` @![Icon](https://acstuff.ru/images/icons_24/weather_cold.png)
---| `ui.Icons.WeatherDrizzle` @![Icon](https://acstuff.ru/images/icons_24/weather_drizzle.png)
---| `ui.Icons.WeatherFewClouds` @![Icon](https://acstuff.ru/images/icons_24/weather_few_clouds.png)
---| `ui.Icons.WeatherFog` @![Icon](https://acstuff.ru/images/icons_24/weather_fog.png)
---| `ui.Icons.WeatherHail` @![Icon](https://acstuff.ru/images/icons_24/weather_hail.png)
---| `ui.Icons.WeatherHot` @![Icon](https://acstuff.ru/images/icons_24/weather_hot.png)
---| `ui.Icons.WeatherHurricane` @![Icon](https://acstuff.ru/images/icons_24/weather_hurricane.png)
---| `ui.Icons.WeatherOvercast` @![Icon](https://acstuff.ru/images/icons_24/weather_overcast.png)
---| `ui.Icons.WeatherRainLight` @![Icon](https://acstuff.ru/images/icons_24/weather_rain_light.png)
---| `ui.Icons.WeatherRain` @![Icon](https://acstuff.ru/images/icons_24/weather_rain.png)
---| `ui.Icons.WeatherSleet` @![Icon](https://acstuff.ru/images/icons_24/weather_sleet.png)
---| `ui.Icons.WeatherSnowLight` @![Icon](https://acstuff.ru/images/icons_24/weather_snow_light.png)
---| `ui.Icons.WeatherSnow` @![Icon](https://acstuff.ru/images/icons_24/weather_snow.png)
---| `ui.Icons.WeatherStormLight` @![Icon](https://acstuff.ru/images/icons_24/weather_storm_light.png)
---| `ui.Icons.WeatherStorm` @![Icon](https://acstuff.ru/images/icons_24/weather_storm.png)
---| `ui.Icons.WeatherTornado` @![Icon](https://acstuff.ru/images/icons_24/weather_tornado.png)
---| `ui.Icons.WeatherWarm` @![Icon](https://acstuff.ru/images/icons_24/weather_warm.png)
---| `ui.Icons.WeatherWindySun` @![Icon](https://acstuff.ru/images/icons_24/weather_windy_sun.png)
---| `ui.Icons.WeatherWindy` @![Icon](https://acstuff.ru/images/icons_24/weather_windy.png)
---| `ui.Icons.YandexMusic` @![Icon](https://acstuff.ru/images/icons_24/yandex_music.png)
---| `ui.Icons.YoutubeSolid` @![Icon](https://acstuff.ru/images/icons_24/youtube_solid.png)
---| `ui.Icons.Youtube` @![Icon](https://acstuff.ru/images/icons_24/youtube.png)
ui.Icons = {
  Apps = 'APPS', ---![Icon](https://acstuff.ru/images/icons_24/apps.png)
  ArrowDown = 'ARROW_DOWN', ---![Icon](https://acstuff.ru/images/icons_24/arrow_down.png)
  ArrowLeft = 'ARROW_LEFT', ---![Icon](https://acstuff.ru/images/icons_24/arrow_left.png)
  ArrowRight = 'ARROW_RIGHT', ---![Icon](https://acstuff.ru/images/icons_24/arrow_right.png)
  ArrowUp = 'ARROW_UP', ---![Icon](https://acstuff.ru/images/icons_24/arrow_up.png)
  Back = 'BACK', ---![Icon](https://acstuff.ru/images/icons_24/back.png)
  Backspace = 'BACKSPACE', ---![Icon](https://acstuff.ru/images/icons_24/backspace.png)
  Ballast = 'BALLAST', ---![Icon](https://acstuff.ru/images/icons_24/ballast.png)
  Ban = 'BAN', ---![Icon](https://acstuff.ru/images/icons_24/ban.png)
  Befriend = 'BEFRIEND', ---![Icon](https://acstuff.ru/images/icons_24/befriend.png)
  Bell = 'BELL', ---![Icon](https://acstuff.ru/images/icons_24/bell.png)
  Bluetooth = 'BLUETOOTH', ---![Icon](https://acstuff.ru/images/icons_24/bluetooth.png)
  Bug = 'BUG', ---![Icon](https://acstuff.ru/images/icons_24/bug.png)
  Bulb = 'BULB', ---![Icon](https://acstuff.ru/images/icons_24/bulb.png)
  Burn = 'BURN', ---![Icon](https://acstuff.ru/images/icons_24/burn.png)
  CallBluetooth = 'CALL_BLUETOOTH', ---![Icon](https://acstuff.ru/images/icons_24/call_bluetooth.png)
  Call = 'CALL', ---![Icon](https://acstuff.ru/images/icons_24/call.png)
  Camera = 'CAMERA', ---![Icon](https://acstuff.ru/images/icons_24/camera.png)
  Cancel = 'CANCEL', ---![Icon](https://acstuff.ru/images/icons_24/cancel.png)
  CarFront = 'CAR_FRONT', ---![Icon](https://acstuff.ru/images/icons_24/car_front.png)
  Clip = 'CLIP', ---![Icon](https://acstuff.ru/images/icons_24/clip.png)
  Clock = 'CLOCK', ---![Icon](https://acstuff.ru/images/icons_24/clock.png)
  Compass = 'COMPASS', ---![Icon](https://acstuff.ru/images/icons_24/compass.png)
  Confirm = 'CONFIRM', ---![Icon](https://acstuff.ru/images/icons_24/confirm.png)
  Copy = 'COPY', ---![Icon](https://acstuff.ru/images/icons_24/copy.png)
  Crosshair = 'CROSSHAIR', ---![Icon](https://acstuff.ru/images/icons_24/crosshair.png)
  Delete = 'DELETE', ---![Icon](https://acstuff.ru/images/icons_24/delete.png)
  Down = 'DOWN', ---![Icon](https://acstuff.ru/images/icons_24/down.png)
  Download = 'DOWNLOAD', ---![Icon](https://acstuff.ru/images/icons_24/download.png)
  Earth = 'EARTH', ---![Icon](https://acstuff.ru/images/icons_24/earth.png)
  Edit = 'EDIT', ---![Icon](https://acstuff.ru/images/icons_24/edit.png)
  Ellipsis = 'ELLIPSIS', ---![Icon](https://acstuff.ru/images/icons_24/ellipsis.png)
  Enter = 'ENTER', ---![Icon](https://acstuff.ru/images/icons_24/enter.png)
  Eye = 'EYE', ---![Icon](https://acstuff.ru/images/icons_24/eye.png)
  FastForward = 'FAST_FORWARD', ---![Icon](https://acstuff.ru/images/icons_24/fast_forward.png)
  File = 'FILE', ---![Icon](https://acstuff.ru/images/icons_24/file.png)
  Finish = 'FINISH', ---![Icon](https://acstuff.ru/images/icons_24/finish.png)
  FM = 'FM', ---![Icon](https://acstuff.ru/images/icons_24/fm.png)
  Folder = 'FOLDER', ---![Icon](https://acstuff.ru/images/icons_24/folder.png)
  Fuel = 'FUEL', ---![Icon](https://acstuff.ru/images/icons_24/fuel.png)
  Global = 'GLOBAL', ---![Icon](https://acstuff.ru/images/icons_24/global.png)
  GlowThick = 'GLOW_THICK', ---![Icon](https://acstuff.ru/images/icons_24/glow_thick.png)
  Glow = 'GLOW', ---![Icon](https://acstuff.ru/images/icons_24/glow.png)
  GPS = 'GPS', ---![Icon](https://acstuff.ru/images/icons_24/gps.png)
  Group = 'GROUP', ---![Icon](https://acstuff.ru/images/icons_24/group.png)
  Hammer = 'HAMMER', ---![Icon](https://acstuff.ru/images/icons_24/hammer.png)
  Hide = 'HIDE', ---![Icon](https://acstuff.ru/images/icons_24/hide.png)
  Horizontal = 'HORIZONTAL', ---![Icon](https://acstuff.ru/images/icons_24/horizontal.png)
  Info = 'INFO', ---![Icon](https://acstuff.ru/images/icons_24/info.png)
  Key = 'KEY', ---![Icon](https://acstuff.ru/images/icons_24/key.png)
  Kick = 'KICK', ---![Icon](https://acstuff.ru/images/icons_24/kick.png)
  Landscape = 'LANDSCAPE', ---![Icon](https://acstuff.ru/images/icons_24/landscape.png)
  Leaderboard = 'LEADERBOARD', ---![Icon](https://acstuff.ru/images/icons_24/leaderboard.png)
  Leave = 'LEAVE', ---![Icon](https://acstuff.ru/images/icons_24/leave.png)
  Lens = 'LENS', ---![Icon](https://acstuff.ru/images/icons_24/lens.png)
  Loading = 'LOADING', ---![Icon](https://acstuff.ru/images/icons_24/loading.png)
  Location = 'LOCATION', ---![Icon](https://acstuff.ru/images/icons_24/location.png)
  Lua = 'LUA', ---![Icon](https://acstuff.ru/images/icons_24/lua.png)
  Map = 'MAP', ---![Icon](https://acstuff.ru/images/icons_24/map.png)
  Menu = 'MENU', ---![Icon](https://acstuff.ru/images/icons_24/menu.png)
  Minus = 'MINUS', ---![Icon](https://acstuff.ru/images/icons_24/minus.png)
  Monitor = 'MONITOR', ---![Icon](https://acstuff.ru/images/icons_24/monitor.png)
  Music = 'MUSIC', ---![Icon](https://acstuff.ru/images/icons_24/music.png)
  Mute = 'MUTE', ---![Icon](https://acstuff.ru/images/icons_24/mute.png)
  Navigation = 'NAVIGATION', ---![Icon](https://acstuff.ru/images/icons_24/navigation.png)
  Next = 'NEXT', ---![Icon](https://acstuff.ru/images/icons_24/next.png)
  NotificationsAny = 'NOTIFICATIONS_ANY', ---![Icon](https://acstuff.ru/images/icons_24/notifications_any.png)
  Notifications = 'NOTIFICATIONS', ---![Icon](https://acstuff.ru/images/icons_24/notifications.png)
  Palette = 'PALETTE', ---![Icon](https://acstuff.ru/images/icons_24/palette.png)
  Paste = 'PASTE', ---![Icon](https://acstuff.ru/images/icons_24/paste.png)
  Pause = 'PAUSE', ---![Icon](https://acstuff.ru/images/icons_24/pause.png)
  Pedals = 'PEDALS', ---![Icon](https://acstuff.ru/images/icons_24/pedals.png)
  Pin = 'PIN', ---![Icon](https://acstuff.ru/images/icons_24/pin.png)
  PitStop = 'PIT_STOP', ---![Icon](https://acstuff.ru/images/icons_24/pit_stop.png)
  Play = 'PLAY', ---![Icon](https://acstuff.ru/images/icons_24/play.png)
  Plus = 'PLUS', ---![Icon](https://acstuff.ru/images/icons_24/plus.png)
  Preview = 'PREVIEW', ---![Icon](https://acstuff.ru/images/icons_24/preview.png)
  Process = 'PROCESS', ---![Icon](https://acstuff.ru/images/icons_24/process.png)
  Python = 'PYTHON', ---![Icon](https://acstuff.ru/images/icons_24/python.png)
  QuestionSign = 'QUESTION_SIGN', ---![Icon](https://acstuff.ru/images/icons_24/question_sign.png)
  Referee = 'REFEREE', ---![Icon](https://acstuff.ru/images/icons_24/referee.png)
  Repair = 'REPAIR', ---![Icon](https://acstuff.ru/images/icons_24/repair.png)
  RestartWarning = 'RESTART_WARNING', ---![Icon](https://acstuff.ru/images/icons_24/restart_warning.png)
  Restart = 'RESTART', ---![Icon](https://acstuff.ru/images/icons_24/restart.png)
  Restrictor = 'RESTRICTOR', ---![Icon](https://acstuff.ru/images/icons_24/restrictor.png)
  Resume = 'RESUME', ---![Icon](https://acstuff.ru/images/icons_24/resume.png)
  Rewind = 'REWIND', ---![Icon](https://acstuff.ru/images/icons_24/rewind.png)
  Road = 'ROAD', ---![Icon](https://acstuff.ru/images/icons_24/road.png)
  Rubber = 'RUBBER', ---![Icon](https://acstuff.ru/images/icons_24/rubber.png)
  SatelliteDishLow = 'SATELLITE_DISH_LOW', ---![Icon](https://acstuff.ru/images/icons_24/satellite_dish_low.png)
  SatelliteDishNone = 'SATELLITE_DISH_NONE', ---![Icon](https://acstuff.ru/images/icons_24/satellite_dish_none.png)
  SatelliteDish = 'SATELLITE_DISH', ---![Icon](https://acstuff.ru/images/icons_24/satellite_dish.png)
  Save = 'SAVE', ---![Icon](https://acstuff.ru/images/icons_24/save.png)
  Sea = 'SEA', ---![Icon](https://acstuff.ru/images/icons_24/sea.png)
  Search = 'SEARCH', ---![Icon](https://acstuff.ru/images/icons_24/search.png)
  Send = 'SEND', ---![Icon](https://acstuff.ru/images/icons_24/send.png)
  Settings = 'SETTINGS', ---![Icon](https://acstuff.ru/images/icons_24/settings.png)
  ShiftActive = 'SHIFT_ACTIVE', ---![Icon](https://acstuff.ru/images/icons_24/shift_active.png)
  Shift = 'SHIFT', ---![Icon](https://acstuff.ru/images/icons_24/shift.png)
  Skip = 'SKIP', ---![Icon](https://acstuff.ru/images/icons_24/skip.png)
  Sleep = 'SLEEP', ---![Icon](https://acstuff.ru/images/icons_24/sleep.png)
  Sliders = 'SLIDERS', ---![Icon](https://acstuff.ru/images/icons_24/sliders.png)
  SlowMotion = 'SLOW_MOTION', ---![Icon](https://acstuff.ru/images/icons_24/slow_motion.png)
  Smile = 'SMILE', ---![Icon](https://acstuff.ru/images/icons_24/smile.png)
  Speedometer = 'SPEEDOMETER', ---![Icon](https://acstuff.ru/images/icons_24/speedometer.png)
  Spotify = 'SPOTIFY', ---![Icon](https://acstuff.ru/images/icons_24/spotify.png)
  StarEmpty = 'STAR_EMPTY', ---![Icon](https://acstuff.ru/images/icons_24/star_empty.png)
  StarFull = 'STAR_FULL', ---![Icon](https://acstuff.ru/images/icons_24/star_full.png)
  StarHalf = 'STAR_HALF', ---![Icon](https://acstuff.ru/images/icons_24/star_half.png)
  Start = 'START', ---![Icon](https://acstuff.ru/images/icons_24/start.png)
  Stay = 'STAY', ---![Icon](https://acstuff.ru/images/icons_24/stay.png)
  SteeringWheel = 'STEERING_WHEEL', ---![Icon](https://acstuff.ru/images/icons_24/steering_wheel.png)
  Stopwatch = 'STOPWATCH', ---![Icon](https://acstuff.ru/images/icons_24/stopwatch.png)
  Tag = 'TAG', ---![Icon](https://acstuff.ru/images/icons_24/tag.png)
  Target = 'TARGET', ---![Icon](https://acstuff.ru/images/icons_24/target.png)
  Teleport = 'TELEPORT', ---![Icon](https://acstuff.ru/images/icons_24/teleport.png)
  Thermometer = 'THERMOMETER', ---![Icon](https://acstuff.ru/images/icons_24/thermometer.png)
  TrafficLight = 'TRAFFIC_LIGHT', ---![Icon](https://acstuff.ru/images/icons_24/traffic_light.png)
  Transmission = 'TRANSMISSION', ---![Icon](https://acstuff.ru/images/icons_24/transmission.png)
  Undo = 'UNDO', ---![Icon](https://acstuff.ru/images/icons_24/undo.png)
  Up = 'UP', ---![Icon](https://acstuff.ru/images/icons_24/up.png)
  Verified = 'VERIFIED', ---![Icon](https://acstuff.ru/images/icons_24/verified.png)
  VideoCamera = 'VIDEO_CAMERA', ---![Icon](https://acstuff.ru/images/icons_24/video_camera.png)
  VolumeHigh = 'VOLUME_HIGH', ---![Icon](https://acstuff.ru/images/icons_24/volume_high.png)
  VolumeLow = 'VOLUME_LOW', ---![Icon](https://acstuff.ru/images/icons_24/volume_low.png)
  VolumeMedium = 'VOLUME_MEDIUM', ---![Icon](https://acstuff.ru/images/icons_24/volume_medium.png)
  Warning = 'WARNING', ---![Icon](https://acstuff.ru/images/icons_24/warning.png)
  WeatherClear = 'WEATHER_CLEAR', ---![Icon](https://acstuff.ru/images/icons_24/weather_clear.png)
  WeatherCold = 'WEATHER_COLD', ---![Icon](https://acstuff.ru/images/icons_24/weather_cold.png)
  WeatherDrizzle = 'WEATHER_DRIZZLE', ---![Icon](https://acstuff.ru/images/icons_24/weather_drizzle.png)
  WeatherFewClouds = 'WEATHER_FEW_CLOUDS', ---![Icon](https://acstuff.ru/images/icons_24/weather_few_clouds.png)
  WeatherFog = 'WEATHER_FOG', ---![Icon](https://acstuff.ru/images/icons_24/weather_fog.png)
  WeatherHail = 'WEATHER_HAIL', ---![Icon](https://acstuff.ru/images/icons_24/weather_hail.png)
  WeatherHot = 'WEATHER_HOT', ---![Icon](https://acstuff.ru/images/icons_24/weather_hot.png)
  WeatherHurricane = 'WEATHER_HURRICANE', ---![Icon](https://acstuff.ru/images/icons_24/weather_hurricane.png)
  WeatherOvercast = 'WEATHER_OVERCAST', ---![Icon](https://acstuff.ru/images/icons_24/weather_overcast.png)
  WeatherRainLight = 'WEATHER_RAIN_LIGHT', ---![Icon](https://acstuff.ru/images/icons_24/weather_rain_light.png)
  WeatherRain = 'WEATHER_RAIN', ---![Icon](https://acstuff.ru/images/icons_24/weather_rain.png)
  WeatherSleet = 'WEATHER_SLEET', ---![Icon](https://acstuff.ru/images/icons_24/weather_sleet.png)
  WeatherSnowLight = 'WEATHER_SNOW_LIGHT', ---![Icon](https://acstuff.ru/images/icons_24/weather_snow_light.png)
  WeatherSnow = 'WEATHER_SNOW', ---![Icon](https://acstuff.ru/images/icons_24/weather_snow.png)
  WeatherStormLight = 'WEATHER_STORM_LIGHT', ---![Icon](https://acstuff.ru/images/icons_24/weather_storm_light.png)
  WeatherStorm = 'WEATHER_STORM', ---![Icon](https://acstuff.ru/images/icons_24/weather_storm.png)
  WeatherTornado = 'WEATHER_TORNADO', ---![Icon](https://acstuff.ru/images/icons_24/weather_tornado.png)
  WeatherWarm = 'WEATHER_WARM', ---![Icon](https://acstuff.ru/images/icons_24/weather_warm.png)
  WeatherWindySun = 'WEATHER_WINDY_SUN', ---![Icon](https://acstuff.ru/images/icons_24/weather_windy_sun.png)
  WeatherWindy = 'WEATHER_WINDY', ---![Icon](https://acstuff.ru/images/icons_24/weather_windy.png)
  YandexMusic = 'YANDEX_MUSIC', ---![Icon](https://acstuff.ru/images/icons_24/yandex_music.png)
  YoutubeSolid = 'YOUTUBE_SOLID', ---![Icon](https://acstuff.ru/images/icons_24/youtube_solid.png)
  Youtube = 'YOUTUBE', ---![Icon](https://acstuff.ru/images/icons_24/youtube.png)
}

---@alias ui.ButtonFlags
---| `ui.ButtonFlags.None` @No special options.
---| `ui.ButtonFlags.Repeat` @Hold to repeat.
---| `ui.ButtonFlags.PressedOnClickRelease` @Return true on click + release on same item.
---| `ui.ButtonFlags.PressedOnClick` @Return true on click (default requires click+release).
---| `ui.ButtonFlags.PressedOnRelease` @Return true on release (default requires click+release).
---| `ui.ButtonFlags.PressedOnDoubleClick` @Return true on double-click (default requires click+release).
---| `ui.ButtonFlags.FlattenChildren` @Allow interactions even if a child window is overlapping.
---| `ui.ButtonFlags.AllowItemOverlap` @Require previous frame HoveredId to either match id or be null before being usable, use along with SetItemAllowOverlap().
---| `ui.ButtonFlags.DontClosePopups` @Disable automatically closing parent popup on press.
---| `ui.ButtonFlags.Disabled` @Disable interactions.
---| `ui.ButtonFlags.NoKeyModifiers` @Disable interaction if a key modifier is held.
---| `ui.ButtonFlags.PressedOnDragDropHold` @Press when held into while we are drag and dropping another item (used by e.g. tree nodes, collapsing headers).
---| `ui.ButtonFlags.NoNavFocus` @Don’t override navigation focus when activated.
---| `ui.ButtonFlags.NoHoveredOnNav` @Don’t report as hovered when navigated on.
---| `ui.ButtonFlags.Active` @Button is correctly active (checked).
---| `ui.ButtonFlags.Activable` @If not set, _Active would make background brighter.
ui.ButtonFlags = {
  None = 0x0, ---No special options.
  Repeat = 0x1, ---Hold to repeat.
  PressedOnClickRelease = 0x2, ---Return true on click + release on same item.
  PressedOnClick = 0x4, ---Return true on click (default requires click+release).
  PressedOnRelease = 0x8, ---Return true on release (default requires click+release).
  PressedOnDoubleClick = 0x10, ---Return true on double-click (default requires click+release).
  FlattenChildren = 0x20, ---Allow interactions even if a child window is overlapping.
  AllowItemOverlap = 0x40, ---Require previous frame HoveredId to either match id or be null before being usable, use along with SetItemAllowOverlap().
  DontClosePopups = 0x80, ---Disable automatically closing parent popup on press.
  Disabled = 0x100, ---Disable interactions.
  NoKeyModifiers = 0x400, ---Disable interaction if a key modifier is held.
  PressedOnDragDropHold = 0x1000, ---Press when held into while we are drag and dropping another item (used by e.g. tree nodes, collapsing headers).
  NoNavFocus = 0x2000, ---Don’t override navigation focus when activated.
  NoHoveredOnNav = 0x4000, ---Don’t report as hovered when navigated on.
  Active = 0x100000, ---Button is correctly active (checked).
  Activable = 0x200000, ---If not set, _Active would make background brighter.
}

---@alias ui.WindowFlags
---| `ui.WindowFlags.None` @No special options.
---| `ui.WindowFlags.NoTitleBar` @Disable title-bar.
---| `ui.WindowFlags.NoResize` @Disable user resizing with the lower-right grip.
---| `ui.WindowFlags.NoMove` @Disable user moving the window.
---| `ui.WindowFlags.NoScrollbar` @Disable scrollbars (window can still scroll with mouse or programmatically).
---| `ui.WindowFlags.NoScrollWithMouse` @Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
---| `ui.WindowFlags.NoCollapse` @Disable user collapsing window by double-clicking on it.
---| `ui.WindowFlags.AlwaysAutoResize` @Resize every window to its content every frame.
---| `ui.WindowFlags.NoBackground` @Disable drawing background and outside border.
---| `ui.WindowFlags.NoSavedSettings` @Never load/save settings in .ini file.
---| `ui.WindowFlags.NoMouseInputs` @Disable catching mouse, hovering test with pass through.
---| `ui.WindowFlags.MenuBar` @Has a menu-bar.
---| `ui.WindowFlags.HorizontalScrollbar` @Allow horizontal scrollbar to appear (off by default).
---| `ui.WindowFlags.NoFocusOnAppearing` @Disable taking focus when transitioning from hidden to visible state.
---| `ui.WindowFlags.NoBringToFrontOnFocus` @Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus).
---| `ui.WindowFlags.AlwaysVerticalScrollbar` @Always show vertical scrollbar (even if ContentSize.y < Size.y).
---| `ui.WindowFlags.AlwaysHorizontalScrollbar` @Always show horizontal scrollbar (even if ContentSize.x < Size.x).
---| `ui.WindowFlags.AlwaysUseWindowPadding` @Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient).
---| `ui.WindowFlags.NoNavInputs` @No gamepad/keyboard navigation within the window.
---| `ui.WindowFlags.NoNavFocus` @No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB).
---| `ui.WindowFlags.UnsavedDocument` @Append “*” to title without affecting the ID, as a convenience to avoid using the “###” operator.
---| `ui.WindowFlags.NoNav` @Combination of flags: NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoNav, …)` to combine it with other flags safely).
---| `ui.WindowFlags.NoDecoration` @Combination of flags: NoTitleBar | NoResize | NoScrollbar | NoCollapse (use `bit.bor(ui.WindowFlags.NoDecoration, …)` to combine it with other flags safely).
---| `ui.WindowFlags.NoInputs` @Combination of flags: NoMouseInputs | NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoInputs, …)` to combine it with other flags safely).
ui.WindowFlags = {
  None = 0x0, ---No special options.
  NoTitleBar = 0x1, ---Disable title-bar.
  NoResize = 0x2, ---Disable user resizing with the lower-right grip.
  NoMove = 0x4, ---Disable user moving the window.
  NoScrollbar = 0x8, ---Disable scrollbars (window can still scroll with mouse or programmatically).
  NoScrollWithMouse = 0x10, ---Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
  NoCollapse = 0x20, ---Disable user collapsing window by double-clicking on it.
  AlwaysAutoResize = 0x40, ---Resize every window to its content every frame.
  NoBackground = 0x80, ---Disable drawing background and outside border.
  NoSavedSettings = 0x100, ---Never load/save settings in .ini file.
  NoMouseInputs = 0x200, ---Disable catching mouse, hovering test with pass through.
  MenuBar = 0x400, ---Has a menu-bar.
  HorizontalScrollbar = 0x800, ---Allow horizontal scrollbar to appear (off by default).
  NoFocusOnAppearing = 0x1000, ---Disable taking focus when transitioning from hidden to visible state.
  NoBringToFrontOnFocus = 0x2000, ---Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus).
  AlwaysVerticalScrollbar = 0x4000, ---Always show vertical scrollbar (even if ContentSize.y < Size.y).
  AlwaysHorizontalScrollbar = 0x8000, ---Always show horizontal scrollbar (even if ContentSize.x < Size.x).
  AlwaysUseWindowPadding = 0x10000, ---Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient).
  NoNavInputs = 0x40000, ---No gamepad/keyboard navigation within the window.
  NoNavFocus = 0x80000, ---No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB).
  UnsavedDocument = 0x100000, ---Append “*” to title without affecting the ID, as a convenience to avoid using the “###” operator.
  NoNav = 0xc0000, ---Combination of flags: NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoNav, …)` to combine it with other flags safely).
  NoDecoration = 0x2b, ---Combination of flags: NoTitleBar | NoResize | NoScrollbar | NoCollapse (use `bit.bor(ui.WindowFlags.NoDecoration, …)` to combine it with other flags safely).
  NoInputs = 0xc0200, ---Combination of flags: NoMouseInputs | NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoInputs, …)` to combine it with other flags safely).
}

---@alias ui.ComboFlags
---| `ui.ComboFlags.None` @No special options.
---| `ui.ComboFlags.PopupAlignLeft` @Align the popup toward the left by default.
---| `ui.ComboFlags.HeightSmall` @Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo().
---| `ui.ComboFlags.HeightRegular` @Max ~8 items visible (default).
---| `ui.ComboFlags.HeightLarge` @Max ~20 items visible.
---| `ui.ComboFlags.HeightLargest` @As many fitting items as possible.
---| `ui.ComboFlags.NoArrowButton` @Display on the preview box without the square arrow button.
---| `ui.ComboFlags.NoPreview` @Display only a square arrow button.
---| `ui.ComboFlags.GoUp` @Dropdown goes up.
---| `ui.ComboFlags.HeightChubby` @Height between regular and large.
ui.ComboFlags = {
  None = 0x0, ---No special options.
  PopupAlignLeft = 0x1, ---Align the popup toward the left by default.
  HeightSmall = 0x2, ---Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo().
  HeightRegular = 0x4, ---Max ~8 items visible (default).
  HeightLarge = 0x8, ---Max ~20 items visible.
  HeightLargest = 0x10, ---As many fitting items as possible.
  NoArrowButton = 0x20, ---Display on the preview box without the square arrow button.
  NoPreview = 0x40, ---Display only a square arrow button.
  GoUp = 0x80, ---Dropdown goes up.
  HeightChubby = 0x100, ---Height between regular and large.
}

---@alias ui.InputTextFlags
---| `ui.InputTextFlags.None` @No special options.
---| `ui.InputTextFlags.CharsDecimal` @Allow “0123456789.+-*/”.
---| `ui.InputTextFlags.CharsHexadecimal` @Allow “0123456789ABCDEFabcdef”.
---| `ui.InputTextFlags.CharsUppercase` @Turn a…z into A…Z.
---| `ui.InputTextFlags.CharsNoBlank` @Filter out spaces, tabs.
---| `ui.InputTextFlags.AutoSelectAll` @Select entire text when first taking mouse focus.
---| `ui.InputTextFlags.AllowTabInput` @Pressing TAB input a '\t' character into the text field.
---| `ui.InputTextFlags.CtrlEnterForNewLine` @In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
---| `ui.InputTextFlags.NoHorizontalScroll` @Disable following the cursor horizontally.
---| `ui.InputTextFlags.AlwaysInsertMode` @Insert mode.
---| `ui.InputTextFlags.ReadOnly` @Read-only mode.
---| `ui.InputTextFlags.Password` @Password mode, display all characters as “*”.
---| `ui.InputTextFlags.NoUndoRedo` @Disable undo/redo. Note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
---| `ui.InputTextFlags.CharsScientific` @Allow “0123456789.+-*/eE” (Scientific notation input).
---| `ui.InputTextFlags.Placeholder` @Show label as a placeholder.
---| `ui.InputTextFlags.ClearButton` @Add button erasing text.
ui.InputTextFlags = {
  None = 0x0, ---No special options.
  CharsDecimal = 0x1, ---Allow “0123456789.+-*/”.
  CharsHexadecimal = 0x2, ---Allow “0123456789ABCDEFabcdef”.
  CharsUppercase = 0x4, ---Turn a…z into A…Z.
  CharsNoBlank = 0x8, ---Filter out spaces, tabs.
  AutoSelectAll = 0x10, ---Select entire text when first taking mouse focus.
  AllowTabInput = 0x400, ---Pressing TAB input a '\t' character into the text field.
  CtrlEnterForNewLine = 0x800, ---In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
  NoHorizontalScroll = 0x1000, ---Disable following the cursor horizontally.
  AlwaysInsertMode = 0x2000, ---Insert mode.
  ReadOnly = 0x4000, ---Read-only mode.
  Password = 0x8000, ---Password mode, display all characters as “*”.
  NoUndoRedo = 0x10000, ---Disable undo/redo. Note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
  CharsScientific = 0x20000, ---Allow “0123456789.+-*/eE” (Scientific notation input).
  Placeholder = 0x400000, ---Show label as a placeholder.
  ClearButton = 0x800000, ---Add button erasing text.
}

---@alias ui.SelectableFlags
---| `ui.SelectableFlags.None` @No special options.
---| `ui.SelectableFlags.DontClosePopups` @Clicking this don’t close parent popup window.
---| `ui.SelectableFlags.SpanAllColumns` @Selectable frame can span all columns (text will still fit in current column).
---| `ui.SelectableFlags.AllowDoubleClick` @Generate press events on double clicks too.
---| `ui.SelectableFlags.Disabled` @Cannot be selected, display grayed out text.
ui.SelectableFlags = {
  None = 0x0, ---No special options.
  DontClosePopups = 0x1, ---Clicking this don’t close parent popup window.
  SpanAllColumns = 0x2, ---Selectable frame can span all columns (text will still fit in current column).
  AllowDoubleClick = 0x4, ---Generate press events on double clicks too.
  Disabled = 0x8, ---Cannot be selected, display grayed out text.
}

---@alias ui.TabBarFlags
---| `ui.TabBarFlags.None` @No special options.
---| `ui.TabBarFlags.Reorderable` @Allow manually dragging tabs to re-order them + New tabs are appended at the end of list.
---| `ui.TabBarFlags.AutoSelectNewTabs` @Automatically select new tabs when they appear.
---| `ui.TabBarFlags.TabListPopupButton` @Disable buttons to open the tab list popup.
---| `ui.TabBarFlags.NoCloseWithMiddleMouseButton` @Disable behavior of closing tabs with middle mouse button.
---| `ui.TabBarFlags.NoTabListScrollingButtons` @Disable scrolling buttons (apply when fitting policy is FittingPolicyScroll).
---| `ui.TabBarFlags.NoTooltip` @Disable tooltips when hovering a tab.
---| `ui.TabBarFlags.FittingPolicyResizeDown` @Resize tabs when they don’t fit.
---| `ui.TabBarFlags.FittingPolicyScroll` @Add scroll buttons when tabs don’t fit.
---| `ui.TabBarFlags.IntegratedTabs` @Integrates tab bar into a window title (call it first when drawing a window).
ui.TabBarFlags = {
  None = 0x0, ---No special options.
  Reorderable = 0x1, ---Allow manually dragging tabs to re-order them + New tabs are appended at the end of list.
  AutoSelectNewTabs = 0x2, ---Automatically select new tabs when they appear.
  TabListPopupButton = 0x4, ---Disable buttons to open the tab list popup.
  NoCloseWithMiddleMouseButton = 0x8, ---Disable behavior of closing tabs with middle mouse button.
  NoTabListScrollingButtons = 0x10, ---Disable scrolling buttons (apply when fitting policy is FittingPolicyScroll).
  NoTooltip = 0x20, ---Disable tooltips when hovering a tab.
  FittingPolicyResizeDown = 0x40, ---Resize tabs when they don’t fit.
  FittingPolicyScroll = 0x80, ---Add scroll buttons when tabs don’t fit.
  IntegratedTabs = 0x8000, ---Integrates tab bar into a window title (call it first when drawing a window).
}

---@alias ui.TabItemFlags
---| `ui.TabItemFlags.None` @Value: 0.
---| `ui.TabItemFlags.UnsavedDocument` @Append '*' to title without affecting the ID, as a convenience to avoid using the ### operator. Also: tab is selected on closure and closure is deferred by one frame to allow code to undo it without flicker.
---| `ui.TabItemFlags.SetSelected` @Trigger flag to programmatically make the tab selected when calling BeginTabItem().
---| `ui.TabItemFlags.NoCloseWithMiddleMouseButton` @Disable behavior of closing tabs (that are submitted with p_open !
ui.TabItemFlags = {
  None = 0, ---Value: 0.
  UnsavedDocument = 1, ---Append '*' to title without affecting the ID, as a convenience to avoid using the ### operator. Also: tab is selected on closure and closure is deferred by one frame to allow code to undo it without flicker.
  SetSelected = 2, ---Trigger flag to programmatically make the tab selected when calling BeginTabItem().
  NoCloseWithMiddleMouseButton = 4, ---Disable behavior of closing tabs (that are submitted with p_open !
}

---@alias ui.TreeNodeFlags
---| `ui.TreeNodeFlags.None` @No special options.
---| `ui.TreeNodeFlags.Selected` @Draw as selected.
---| `ui.TreeNodeFlags.Framed` @Full colored frame (e.g. for CollapsingHeader).
---| `ui.TreeNodeFlags.AllowItemOverlap` @Hit testing to allow subsequent widgets to overlap this one.
---| `ui.TreeNodeFlags.NoTreePushOnOpen` @Don’t do a TreePush() when open (e.g. for CollapsingHeader).
---| `ui.TreeNodeFlags.NoAutoOpenOnLog` @Don’t automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes).
---| `ui.TreeNodeFlags.DefaultOpen` @Default node to be open.
---| `ui.TreeNodeFlags.OpenOnDoubleClick` @Need double-click to open node.
---| `ui.TreeNodeFlags.OpenOnArrow` @Only open when clicking on the arrow part. If OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
---| `ui.TreeNodeFlags.Leaf` @No collapsing, no arrow (use as a convenience for leaf nodes).
---| `ui.TreeNodeFlags.Bullet` @Display a bullet instead of arrow.
---| `ui.TreeNodeFlags.FramePadding` @Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
---| `ui.TreeNodeFlags.CollapsingHeader` @Combination of flags: Framed | NoTreePushOnOpen | NoAutoOpenOnLog (use `bit.bor(ui.TreeNodeFlags.CollapsingHeader, …)` to combine it with other flags safely).
---| `ui.TreeNodeFlags.NoArrow` @Value: 0x4000.
---| `ui.TreeNodeFlags.Animated` @Value: 0xf0000000.
ui.TreeNodeFlags = {
  None = 0x0, ---No special options.
  Selected = 0x1, ---Draw as selected.
  Framed = 0x2, ---Full colored frame (e.g. for CollapsingHeader).
  AllowItemOverlap = 0x4, ---Hit testing to allow subsequent widgets to overlap this one.
  NoTreePushOnOpen = 0x8, ---Don’t do a TreePush() when open (e.g. for CollapsingHeader).
  NoAutoOpenOnLog = 0x10, ---Don’t automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes).
  DefaultOpen = 0x20, ---Default node to be open.
  OpenOnDoubleClick = 0x40, ---Need double-click to open node.
  OpenOnArrow = 0x80, ---Only open when clicking on the arrow part. If OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
  Leaf = 0x100, ---No collapsing, no arrow (use as a convenience for leaf nodes).
  Bullet = 0x200, ---Display a bullet instead of arrow.
  FramePadding = 0x400, ---Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
  CollapsingHeader = 0x1a, ---Combination of flags: Framed | NoTreePushOnOpen | NoAutoOpenOnLog (use `bit.bor(ui.TreeNodeFlags.CollapsingHeader, …)` to combine it with other flags safely).
  NoArrow = 0x4000, ---Value: 0x4000.
  Animated = 0xf0000000, ---Value: 0xf0000000.
}

---@alias ui.ColorPickerFlags
---| `ui.ColorPickerFlags.None` @Value: 0.
---| `ui.ColorPickerFlags.NoAlpha` @Ignore Alpha component (will only read 3 components from the input pointer).
---| `ui.ColorPickerFlags.NoPicker` @Disable picker when clicking on colored square.
---| `ui.ColorPickerFlags.NoOptions` @Disable toggling options menu when right-clicking on inputs/small preview.
---| `ui.ColorPickerFlags.NoSmallPreview` @Disable colored square preview next to the inputs. (e.g. to show only the inputs).
---| `ui.ColorPickerFlags.NoInputs` @Disable inputs sliders/text widgets (e.g. to show only the small preview colored square).
---| `ui.ColorPickerFlags.NoTooltip` @Disable tooltip when hovering the preview.
---| `ui.ColorPickerFlags.NoLabel` @Disable display of inline text label (the label is still forwarded to the tooltip and picker).
---| `ui.ColorPickerFlags.NoSidePreview` @Disable bigger color preview on right side of the picker, use small colored square preview instead.
---| `ui.ColorPickerFlags.NoDragDrop` @Disable drag and drop target. ColorButton: disable drag and drop source.
---| `ui.ColorPickerFlags.AlphaBar` @Show vertical alpha bar/gradient in picker.
---| `ui.ColorPickerFlags.AlphaPreview` @Display preview as a transparent color over a checkerboard, instead of opaque.
---| `ui.ColorPickerFlags.AlphaPreviewHalf` @Display half opaque / half checkerboard, instead of opaque.
---| `ui.ColorPickerFlags.DisplayRGB` @Override _display_ type among RGB/HSV/Hex. select any combination using one or more of RGB/HSV/Hex.
---| `ui.ColorPickerFlags.DisplayHSV` @Value: 2097152.
---| `ui.ColorPickerFlags.DisplayHex` @Value: 4194304.
---| `ui.ColorPickerFlags.UInt8` @Display values formatted as 0..255.
---| `ui.ColorPickerFlags.Float` @Display values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
---| `ui.ColorPickerFlags.PickerHueBar` @Bar for Hue, rectangle for Sat/Value.
---| `ui.ColorPickerFlags.PickerHueWheel` @Wheel for Hue, triangle for Sat/Value.
ui.ColorPickerFlags = {
  None = 0, ---Value: 0.
  NoAlpha = 2, ---Ignore Alpha component (will only read 3 components from the input pointer).
  NoPicker = 4, ---Disable picker when clicking on colored square.
  NoOptions = 8, ---Disable toggling options menu when right-clicking on inputs/small preview.
  NoSmallPreview = 16, ---Disable colored square preview next to the inputs. (e.g. to show only the inputs).
  NoInputs = 32, ---Disable inputs sliders/text widgets (e.g. to show only the small preview colored square).
  NoTooltip = 64, ---Disable tooltip when hovering the preview.
  NoLabel = 128, ---Disable display of inline text label (the label is still forwarded to the tooltip and picker).
  NoSidePreview = 256, ---Disable bigger color preview on right side of the picker, use small colored square preview instead.
  NoDragDrop = 512, ---Disable drag and drop target. ColorButton: disable drag and drop source.
  AlphaBar = 65536, ---Show vertical alpha bar/gradient in picker.
  AlphaPreview = 131072, ---Display preview as a transparent color over a checkerboard, instead of opaque.
  AlphaPreviewHalf = 262144, ---Display half opaque / half checkerboard, instead of opaque.
  DisplayRGB = 1048576, ---Override _display_ type among RGB/HSV/Hex. select any combination using one or more of RGB/HSV/Hex.
  DisplayHSV = 2097152, ---Value: 2097152.
  DisplayHex = 4194304, ---Value: 4194304.
  UInt8 = 8388608, ---Display values formatted as 0..255.
  Float = 16777216, ---Display values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
  PickerHueBar = 33554432, ---Bar for Hue, rectangle for Sat/Value.
  PickerHueWheel = 67108864, ---Wheel for Hue, triangle for Sat/Value.
}

---@alias ui.DWriteFont.Weight
---| `ui.DWriteFont.Weight.Thin` @- Thin (100).
---| `ui.DWriteFont.Weight.UltraLight` @- Ultra-light (200).
---| `ui.DWriteFont.Weight.Light` @- Light (300).
---| `ui.DWriteFont.Weight.SemiLight` @- Semi-light (350).
---| `ui.DWriteFont.Weight.Regular` @- Regular (400).
---| `ui.DWriteFont.Weight.Medium` @- Medium (500).
---| `ui.DWriteFont.Weight.SemiBold` @- Semi-bold (600).
---| `ui.DWriteFont.Weight.Bold` @- Bold (700).
---| `ui.DWriteFont.Weight.UltraBold` @- Ultra-bold (800).
---| `ui.DWriteFont.Weight.Black` @- Black (900).
---| `ui.DWriteFont.Weight.UltraBlack` @- Ultra-black (950).
ui.DWriteFont.Weight = {
  Thin = 'Thin', ---- Thin (100).
  UltraLight = 'UltraLight', ---- Ultra-light (200).
  Light = 'Light', ---- Light (300).
  SemiLight = 'SemiLight', ---- Semi-light (350).
  Regular = 'Regular', ---- Regular (400).
  Medium = 'Medium', ---- Medium (500).
  SemiBold = 'SemiBold', ---- Semi-bold (600).
  Bold = 'Bold', ---- Bold (700).
  UltraBold = 'UltraBold', ---- Ultra-bold (800).
  Black = 'Black', ---- Black (900).
  UltraBlack = 'UltraBlack', ---- Ultra-black (950).
}

---@alias ui.DWriteFont.Style
---| `ui.DWriteFont.Style.Normal` @- Charachers are upright in most fonts.
---| `ui.DWriteFont.Style.Italic` @- In italic style, characters are truly slanted and appear as they were designed.
---| `ui.DWriteFont.Style.Oblique` @- With oblique style characters are artificially slanted.
ui.DWriteFont.Style = {
  Normal = 'Normal', ---- Charachers are upright in most fonts.
  Italic = 'Italic', ---- In italic style, characters are truly slanted and appear as they were designed.
  Oblique = 'Oblique', ---- With oblique style characters are artificially slanted.
}

---@alias ui.DWriteFont.Stretch
---| `ui.DWriteFont.Stretch.UltraCondensed` @Value: 'UltraCondensed'.
---| `ui.DWriteFont.Stretch.ExtraCondensed` @Value: 'ExtraCondensed'.
---| `ui.DWriteFont.Stretch.Condensed` @Value: 'Condensed'.
---| `ui.DWriteFont.Stretch.SemiCondensed` @Value: 'SemiCondensed'.
---| `ui.DWriteFont.Stretch.Medium` @Value: 'Medium'.
---| `ui.DWriteFont.Stretch.SemiExpanded` @Value: 'SemiExpanded'.
---| `ui.DWriteFont.Stretch.Expanded` @Value: 'Expanded'.
---| `ui.DWriteFont.Stretch.ExtraExpanded` @Value: 'ExtraExpanded'.
---| `ui.DWriteFont.Stretch.UltraExpanded` @Value: 'UltraExpanded'.
ui.DWriteFont.Stretch = {
  UltraCondensed = 'UltraCondensed', ---Value: 'UltraCondensed'.
  ExtraCondensed = 'ExtraCondensed', ---Value: 'ExtraCondensed'.
  Condensed = 'Condensed', ---Value: 'Condensed'.
  SemiCondensed = 'SemiCondensed', ---Value: 'SemiCondensed'.
  Medium = 'Medium', ---Value: 'Medium'.
  SemiExpanded = 'SemiExpanded', ---Value: 'SemiExpanded'.
  Expanded = 'Expanded', ---Value: 'Expanded'.
  ExtraExpanded = 'ExtraExpanded', ---Value: 'ExtraExpanded'.
  UltraExpanded = 'UltraExpanded', ---Value: 'UltraExpanded'.
}

---@alias ac.IncludeType
---| `ac.IncludeType.None` @Value: 0.
---| `ac.IncludeType.Car` @Value: 1.
---| `ac.IncludeType.Track` @Value: 2.
ac.IncludeType = {
  None = 0, ---Value: 0.
  Car = 1, ---Value: 1.
  Track = 2, ---Value: 2.
}

--[[ csp.lua ]]

---Loads FMOD soundbank. After soundbank is loaded, new audio events can be created which would refer to
---events in the soundbank. If soundbank is missing, new audio events can still be created, but they won’t be
---valid. If second parameter is missing, “GUIDs.txt” in the same folder as soundbank will be loaded. Returns
---true if both files were found properly. Also, if used before audio engine is initialized, it would postpone
---loading until that happens (function returns straight away, and you can create new audio events straight
---away, but they would only become valid after audio initialization is complete).
---@param soundbank string @Path to “.bank” file, could be absolute or relative to Lua script folder.
---@param guids string|nil @Path to “.txt” file with GUIDs, if missing, “GUIDs.txt” from soundbank folder will be used. Default value: `nil`.
---@return boolean @Returns `true` if both files were found.
function ac.loadSoundbank(soundbank, guids) end

---Checks if audio engine is initialized and ready to work. Until then, all created audio events would return `false`
---in their `:isValid()` methods, it doesn’t mean that there is a problem with soundbank (yet).
---@return boolean
function ac.isAudioReady() end

---@param surfaceWav string
---@param mult number
---@return boolean
function ac.setAudioEventMultiplier(surfaceWav, mult) end

---@param center vec3
---@param radius number
---@return boolean
function render.isVisible(center, radius) end

---@param mode render.BlendMode
function render.setBlendMode(mode) end

---@param mode render.CullMode
function render.setCullMode(mode) end

---@param mode render.DepthMode
function render.setDepthMode(mode) end

---@param color rgbm
function render.glSetColor(color) end

---@param primitiveType render.GLPrimitiveType
function render.glBegin(primitiveType) end

---@param v vec3
function render.glVertex(v) end

---@param v vec3
---@param uv vec2
function render.glVertexTextured(v, uv) end

---@param filename string
function render.glTexture(filename) end

function render.glEnd() end

---Draws a simple circle othrogonal to `dir` direction using an optimized shader.
---@param pos vec3
---@param dir vec3
---@param radius number
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param borderColor rgbm|nil @Optional different color to use close to the border. Default value: `nil`.
function render.circle(pos, dir, radius, color, borderColor) end

---Draws a simple rectangle othrogonal to `dir` direction using an optimized shader.
---@param pos vec3
---@param dir vec3
---@param width number
---@param height number
---@param color rgbm? @Default value: `rgbm.colors.white`.
function render.rectangle(pos, dir, width, height, color) end

---Draws a simple quad from four points.
---@param p1 vec3
---@param p2 vec3
---@param p3 vec3
---@param p4 vec3
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param texture string|nil @Default value: `nil`.
function render.quad(p1, p2, p3, p4, color, texture) end

---Affects positioning of debug shapes drawn next.
---@param t mat4x4
---@param applySceneOriginOffset boolean? @Use it if your matrix is in world-space and not in graphics-space. Default value: `false`.
function render.setTransform(t, applySceneOriginOffset) end

---@param pos vec3
---@param text string
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param scale number? @Default value: 1.
---@param align render.FontAlign? @Default value: `AC::FontAlign::center`.
function render.debugText(pos, text, color, scale, align) end

---@param center vec3
---@param radius number
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugSphere(center, radius, color) end

---@param center vec3
---@param size number
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugCross(center, size, color) end

---@param center vec3
---@param size vec3
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugBox(center, size, color) end

---@param center vec3
---@param size number
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugPoint(center, size, color) end

---@param center vec3
---@param dir vec3
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
---@param size number? @Default value: 1.
function render.debugPlane(center, dir, color, size) end

---@param from vec3
---@param to vec3
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugLine(from, to, color) end

---@param from vec3
---@param to vec3
---@param size number? @Default value: -1.
---@param color rgbm? @Default value: `rgbm(3, 0, 0, 1)`.
function render.debugArrow(from, to, size, color) end

---@return vec2
function render.getRenderTargetSize() end

---@return boolean
function render.backupRenderTarget() end

---@return boolean
function render.restoreRenderTarget() end

---@param pos vec3
---@param dir vec3
---@param length number? @Default value: -1.
---@return ray
function render.createRay(pos, dir, length) end

---@return ray
function render.createMouseRay() end

---@param onscreenPoint vec2
---@return ray
function render.createPointRay(onscreenPoint) end

---@return boolean
function render.isPositioningHelperBusy() end

---It’s safer to use `ui.toolWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param windowID string
---@param pos vec2
---@param size vec2
---@param noPadding boolean|`true`|`false`
function ui.beginToolWindow(windowID, pos, size, noPadding) end

function ui.endToolWindow() end

---It’s safer to use `ui.transparentWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param windowID string
---@param pos vec2
---@param size vec2
---@param noPadding boolean|`true`|`false`
function ui.beginTransparentWindow(windowID, pos, size, noPadding) end

function ui.endTransparentWindow() end

---@param text string
---@return boolean
function ui.textHyperlink(text) end

---@param text string
function ui.text(text) end

---@param text string
---@param alignment vec2
---@param size vec2? @Default value: `vec2(0, 0)`.
function ui.textAligned(text, alignment, size) end

---@param text string
---@param wrapPos number? @Default value: 0.
function ui.textWrapped(text, wrapPos) end

---@param text string
---@param color rgbm
function ui.textColored(text, color) end

---Display text and label aligned the same way as value and label widgets.
---@param label string
---@param text string
function ui.labelText(label, text) end

---Shortcut for pushing disabled text color, drawing text and popping it back;.
---@param text string
function ui.textDisabled(text) end

---Returns `true` if 24×24 icon with such ID is known.
---@param iconID ui.Icons
---@return boolean
function ui.isKnownIcon24(iconID) end

---Draws an icon, universal function (great for creating customizable components). Icon can be:
---- An 24×24 icon ID set as is;
---- A country code for a small flag with padding to fit a square;
---- An 32×32 icon ID with “32:” prefix;
---- An 64×64 icon ID with “64:” prefix;
---- An 256×256 icon ID with “XL:” prefix;
---- A large rectangular flag with no padding with “XS:” prefix;
---- An emoticon with “em:” prefix;
---- An icon from an atlas: use “at:FILENAME\nX1,Y1,X2,Y2” format, where X… and Y… are UV coordinates (`ui.atlasIconID()` can help with generating those IDs);
---- A regular image: just pass a path as a string (also works with extra canvases, media elements and such).
---@param iconID ui.Icons
---@param size vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
---@param iconSize vec2|nil @If set, icon will be this size, but item will be larger (use it if you need to fill an area without stretching an icon). Default value: `nil`.
function ui.icon(iconID, size, tintCol, iconSize) end

---Adds an icon to the previously drawn element.
---@param iconID ui.Icons
---@param size vec2 @Size of an icon.
---@param alignment vec2 @Alignment of an icon relative to the element.
---@param colorOpt rgbm|nil @If not set, uses text color by default. Default value: `nil`.
---@param padding vec2|nil @If not set, uses frame padding by default. Default value: `nil`.
function ui.addIcon(iconID, size, alignment, colorOpt, padding) end

---Draws a 24×24 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon24(iconID, size, tintCol) end

---Draws a 32×32 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon32(iconID, size, tintCol) end

---Draws a 64×64 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon64(iconID, size, tintCol) end

---Draws a flag. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.flag(iconID, size, tintCol) end

---@return vec2
function ui.getCursor() end

---@param v vec2
function ui.setCursor(v) end

---@param v vec2
function ui.offsetCursor(v) end

---@return number
function ui.getCursorX() end

---@param v number
function ui.setCursorX(v) end

---@return number
function ui.getCursorY() end

---@param v number
function ui.setCursorY(v) end

---@param v number
function ui.offsetCursorX(v) end

---@param v number
function ui.offsetCursorY(v) end

---@param offsetFromStart number? @Default value: 0.
---@param spacing number? @Default value: -1.
function ui.sameLine(offsetFromStart, spacing) end

---@param spacing number? @If non-negative, value is used for space between lines instead of regular item spacing from current style. Default value: -1.
function ui.newLine(spacing) end

---Lock horizontal starting position and capture group bounding box into one “item” (so you can use `ui.itemHovered()` or layout primitives such as `ui.sameLine()` on whole group, etc.)
function ui.beginGroup() end

---Unlock horizontal starting position and capture the whole group bounding box into one “item” (so you can use `ui.itemHovered()` or layout primitives such as `ui.sameLine()` on whole group, etc.)
function ui.endGroup() end

---@return number
function ui.availableSpaceX() end

---@return number
function ui.availableSpaceY() end

---@return vec2
function ui.availableSpace() end

---Returns image size, or zeroes if image is missing or not yet ready.
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@return vec2
function ui.imageSize(filename) end

---Imports image from its binary data. Any formats supported by system are supported. Also, new DDS formats are supported as well. Result is cached,
---so subsequent calls don’t take a lot of time. Data string can contain zeroes.
---
---To clear cached image and free memory, pass returned value to `ui.unloadImage()`.
---@param data string|any
---@return string?
function ui.decodeImage(data) end

---Simply draws an image on canvas without adding a new item or progressing cursor. Current cursor position is not taken
---into consideration either. To add an image as an element, use `ui.image()`.
---
---When drawing multiple images, consider combining all of them in a single atlas texture, it would improve performance.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(filename: string, p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, keepAspectRatio: boolean)
---@overload fun(filename: string, p1: vec2, p2: vec2, keepAspectRatio: boolean)
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.
---@param keepAspectRatio boolean? @Set to `true` to stretch image to fit given size, making sure it would not get distorted. Default value: `false`.
function ui.drawImage(filename, p1, p2, color, uv1, uv2, keepAspectRatio) end

---Draws an image with rounded corners on canvas without adding a new item or progressing cursor. Current cursor position is not taken
---into consideration either. To add an image as an element, use `ui.image()`.
---
---When drawing multiple images, consider combining all of them in a single atlas texture, it would improve performance.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(filename: string, p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, rounding: number, corners: ui.CornerFlags)
---@overload fun(filename: string, p1: vec2, p2: vec2, rounding: number, corners: ui.CornerFlags)
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.
---@param rounding number? @Rounding radius in pixels. Default value: 1.
---@param corners ui.CornerFlags? @Corners to round. Default value: `ImDrawCornerFlags_All`.
function ui.drawImageRounded(filename, p1, p2, color, uv1, uv2, rounding, corners) end

---Draws a custom quad with a texture.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(filename: string, p1: vec2, p2: vec2, p3: vec2, p4: vec2, uv1: vec2, uv2: vec2, uv3: vec2, uv4: vec2)
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 vec2 @Position of first corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 vec2 @Position of second corner relative to current working area (scriptable texture or IMGUI window).
---@param p3 vec2 @Position of third corner relative to current working area (scriptable texture or IMGUI window).
---@param p4 vec2 @Position of fourth corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 vec2? @Texture coordinates for first corner. Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinates for second corner. Default value: `vec2(1, 0)`.
---@param uv3 vec2? @Texture coordinates for third corner. Default value: `vec2(1, 1)`.
---@param uv4 vec2? @Texture coordinates for fourth corner. Default value: `vec2(0, 1)`.
function ui.drawImageQuad(filename, p1, p2, p3, p4, color, uv1, uv2, uv3, uv4) end

---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param p4 vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawQuadFilled(p1, p2, p3, p4, color) end

---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param p4 vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawQuad(p1, p2, p3, p4, color) end

---Marks start of texture shading. All geometry drawn between this call and `ui.endTextureShade()` will have texture applied to it.
---
---Note: this feature only works with geometrical shapes, like quads, triangles, circles or things drawn with `ui.path…` functions.
---It can’t be applied to text, for example: text already uses its own texture.
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
function ui.beginTextureShade(filename) end

---Finishes texture shading. All geometry drawn between `ui.beginTextureShade()` and this call will have texture applied to it.
--- Note: this feature only works with geometrical shapes, like quads, triangles, circles or things drawn with `ui.path…` functions.
--- It can’t be applied to text, for example: text already uses its own texture.
--- @overload fun(p1: vec2, p2: vec2, clamp: boolean)
---@param p1 vec2 @Position within current working area that will get `uv1` texture coordinate.
---@param p2 vec2 @Position within current working area that will get `uv2` texture coordinate.
---@param uv1 vec2? @Texture coordinate for `p1` position (texture will be interpolated between linearly). Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinate for `p2` position (texture will be interpolated between linearly). Default value: `vec2(1, 1)`.
---@param clamp boolean? @If set to `true`, texture will be clamped to boundaries (if there are vertices outside). Otherwise, texture will be repeated. Default value: `true`.
function ui.endTextureShade(p1, p2, uv1, uv2, clamp) end

function ui.beginGradientShade() end

---@param p1 vec2
---@param p2 vec2
---@param col1 rgbm? @Default value: `rgbm.colors.white`.
---@param col2 rgbm? @Default value: `rgbm.colors.white`.
function ui.endGradientShade(p1, p2, col1, col2) end

---@param p1 vec2
---@param p2 vec2
---@param intersectWithExisting boolean? @Default value: `true`.
function ui.pushClipRect(p1, p2, intersectWithExisting) end

---Pretty much fully disables clipping until next `ui.popClipRect()` call.
function ui.pushClipRectFullScreen() end

function ui.popClipRect() end

---@param p1 vec2
---@param p2 vec2
---@param color rgbm
---@param rounding number? @Default value: 0.
---@param roundingFlags ui.CornerFlags? @Default value: `ImDrawCornerFlags_All`.
---@param thickness number? @Default value: 1.
function ui.drawRect(p1, p2, color, rounding, roundingFlags, thickness) end

---@param p1 vec2
---@param p2 vec2
---@param color rgbm
---@param rounding number? @Default value: 0.
---@param roundingFlags ui.CornerFlags? @Default value: `ImDrawCornerFlags_All`.
function ui.drawRectFilled(p1, p2, color, rounding, roundingFlags) end

---@param p1 vec2
---@param p2 vec2
---@param colorTopLeft rgbm
---@param colorTopRight rgbm
---@param colorBottomRight rgbm
---@param colorBottomLeft rgbm
function ui.drawRectFilledMultiColor(p1, p2, colorTopLeft, colorTopRight, colorBottomRight, colorBottomLeft) end

---To quickly draw series of lines and arcs, add points with `ui.PathLineTo()` and `ui.pathArcTo()`, and then finish with `ui.pathStroke()`.
---@param p1 vec2
---@param p2 vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawLine(p1, p2, color, thickness) end

---To quickly draw series of lines and arcs, add points with `ui.PathLineTo()` and `ui.pathArcTo()`, and then finish with `ui.pathStroke()`.
---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param p4 vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawBezierCurve(p1, p2, p3, p4, color, thickness) end

---@param p1 vec2
---@param radius number
---@param color rgbm
---@param numSegments integer? @Default value: 12.
---@param thickness number? @Default value: 1.
function ui.drawCircle(p1, radius, color, numSegments, thickness) end

---@param p1 vec2
---@param radius number
---@param color rgbm
---@param numSegments integer? @Default value: 12.
function ui.drawCircleFilled(p1, radius, color, numSegments) end

---@param p1 vec2
---@param radius vec2
---@param color rgbm
---@param numSegments integer? @Default value: 12.
function ui.drawEllipseFilled(p1, radius, color, numSegments) end

---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawTriangle(p1, p2, p3, color, thickness) end

---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param color rgbm
function ui.drawTriangleFilled(p1, p2, p3, color) end

---Draws text in given position without advancing cursor or anything like that. Faster option.
---@param text string
---@param pos vec2
---@param color rgbm
function ui.drawText(text, pos, color) end

---Draws TTF text in given position without advancing cursor or anything like that. Faster option.
---@param text string
---@param fontSize number
---@param pos vec2
---@param color rgbm
function ui.dwriteDrawText(text, fontSize, pos, color) end

---Clears current path. Not really needed in common scenarios: to start a new path, simply use any of
---path-adding functions such as `ui.pathLineTo()` or `ui.pathArcTo()`, to finish path and draw a shape use
---either `ui.pathFillConvex()` or `ui.pathStroke()` and it would clear path for the next shape automatically.
function ui.pathClear() end

---Adds a line segment to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param pos vec2
function ui.pathLineTo(pos) end

---Adds a line segment to current path, but only if position is different from current path point position.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param pos vec2
function ui.pathLineToMergeDuplicate(pos) end

---@param color rgbm
function ui.pathFillConvex(color) end

---@param color rgbm
---@param closed boolean? @Default value: `false`.
---@param thickness number? @Default value: 1.
function ui.pathStroke(color, closed, thickness) end

---Adds an arc defined by its center, radius and starting and finishing angle to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center vec2
---@param radius number
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathArcTo(center, radius, angleFrom, angleTo, numSegments) end

---Adds “squished” arc to current path, like an arc of axis-aligned ellipse rather than an arc of a circle.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center vec2
---@param radius vec2
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathUnevenArcTo(center, radius, angleFrom, angleTo, numSegments) end

---Adds arc with radius at the end different from radius at the beginning.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center vec2
---@param radiusFrom number
---@param radiusTo number
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathVariableArcTo(center, radiusFrom, radiusTo, angleFrom, angleTo, numSegments) end

---Uses precomputed angles for a 12 steps circle.
---@param center vec2
---@param radius number
---@param angleMinOf_12 integer
---@param angleMaxOf_12 integer
function ui.pathArcToFast(center, radius, angleMinOf_12, angleMaxOf_12) end

---Adds a bezier curve to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param p1 vec2
---@param p2 vec2
---@param p3 vec2
---@param numSegments integer? @Default value: 0.
function ui.pathBezierCurveTo(p1, p2, p3, numSegments) end

---@param rectMin vec2
---@param rectMax vec2
---@param rounding number? @Default value: 0.
---@param roundingCorners ui.CornerFlags? @Default value: `ImDrawCornerFlags_All`.
function ui.pathRect(rectMin, rectMax, rounding, roundingCorners) end

---Adds a rect to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 vec2
---@param p2 vec2
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowRectFilled(p1, p2, color, noClip) end

---Adds a circle to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 vec2
---@param radius number
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowCircleFilled(p1, radius, color, noClip) end

---Adds an ellipse to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 vec2
---@param radius vec2
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowEllipseFilled(p1, radius, color, noClip) end

---Returns number of draw command in current IMGUI drawing context. Each command is its own draw call.
---@return integer
function ui.getDrawCommandsCount() end

function ui.beginTextureSaturationAdjustment() end

---@param value number
function ui.endTextureSaturationAdjustment(value) end

function ui.beginOutline() end

---@param color rgbm
---@param scale number? @Default value: 1.
function ui.endOutline(color, scale) end

function ui.beginSharpening() end

---@param sharpening number? @Default value: 1.
function ui.endSharpening(sharpening) end

function ui.beginBlurring() end

---@param blurring vec2
function ui.endBlurring(blurring) end

---Begins rotation. Call this function before drawing elements you need to rotate, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endRotation()`, would turn all new vertices by specified angle.
function ui.beginRotation() end

---Does actual rotation counterclockwise (or clockwise with negative values; also see note). Call this function after calling
---`ui.beginRotation()` and drawing elements you need to rotate. This version would automatically calculate pivot as middle point
---of drawn elements.
---
---Note: angle of rotation is offset by 90, kept this way for compatibility. Just subtract 90 from `deg` for it to act normal.
---@param deg number @Angle in degrees.
---@param offset vec2? @Optional offset. Default value: `vec2(0, 0)`.
function ui.endRotation(deg, offset) end

---Does actual rotation counterclockwise (or clockwise with negative values; also see note). Call this function after calling
---`ui.beginRotation()` and drawing elements you need to rotate. This version uses provided pivot to rotate things around.
---
---Note: angle of rotation is offset by 90, kept this way for compatibility. Just subtract 90 from `deg` for it to act normal.
---@param deg number @Angle in degrees.
---@param pivot vec2 @Point around which things would rotate, in window space.
---@param offset vec2? @Optional offset. Default value: `vec2(0, 0)`.
function ui.endPivotRotation(deg, pivot, offset) end

---Call this function first to apply any further transformations to subsequently drawn windows.
---
---Be careful with it! While it allows to transform windows around, it doesn’t work all that well when clipping
---gets involved, and it gets involved all the time.
---@param active boolean? @Default value: `true`.
function ui.applyTransformationToWindows(active) end

---Begins scaling. Call this function before drawing elements you need to scale, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endScale()`, would scale all new vertices by specified value.
function ui.beginScale() end

---Does actual scaling. Call this function after calling `ui.beginScale()` and drawing elements you need to scale. This
---version would automatically calculate pivot as middle point of drawn elements.
---@param scale vec2 @Scale, could be a 2-dimensional vector or a single number.
function ui.endScale(scale) end

---Does actual scaling. Call this function after calling `ui.beginScale()` and drawing elements you need to scale. This
---version uses provided pivot to scale things around.
---@param scale vec2 @Scale, could be a 2-dimensional vector or a single number.
---@param pivot vec2 @Point around which things would scale, in window space.
function ui.endPivotScale(scale, pivot) end

---Begins transformation. Call this function before drawing elements you need to scale, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endTransformMatrix()`, would transform all new vertices by specified matrix.
function ui.beginTransformMatrix() end

---Does actual transformation. Call this function after calling `ui.beginTransformMatrix()` and drawing elements you need to scale.
---@param mat mat3x3 @Transformation matrix.
function ui.endTransformMatrix(mat) end

---@param count integer? @Default value: 1.
function ui.popStyleVar(count) end

---@param varID ui.StyleColor
---@param value rgbm
function ui.pushStyleColor(varID, value) end

---@param count integer? @Default value: 1.
function ui.popStyleColor(count) end

---@param fontType ui.Font
function ui.pushFont(fontType) end

function ui.popFont() end

---@param itemWidth number
function ui.pushItemWidth(itemWidth) end

function ui.popItemWidth() end

---@param wrapPos number
function ui.pushTextWrapPosition(wrapPos) end

function ui.popTextWrapPosition() end

---Checks if area is visible (not clipped). Works great if you need to make a list with many elements and don’t want to render elements
---outside of scroll (just make sure to offset cursor instead of drawing them using, of example, `ui.offsetCursorY(itemHeight)`).
---@param size vec2
---@return boolean
function ui.areaVisible(size) end

---Checks if area is visible (not clipped). Works great if you need to make a list with many elements and don’t want to render elements
---outside of scroll (just make sure to offset cursor instead of drawing them using, of example, `ui.offsetCursorY(itemHeight)`).
---@param height number
---@return boolean
function ui.areaVisibleY(height) end

---@param p1 vec2
---@param p2 vec2
---@return boolean
function ui.rectVisible(p1, p2) end

---@param p1 vec2
---@param p2 vec2
---@param clip boolean? @Default value: `true`.
---@return boolean
function ui.rectHovered(p1, p2, clip) end

---Make last item the default focused item of a window.
function ui.setItemDefaultFocus() end

---Focus keyboard on the next widget. Use positive `offset` to access sub components of a multiple component widget. Use `-1` to access previous widget.
---@param offset integer? @Default value: 0.
function ui.setKeyboardFocusHere(offset) end

---@return number
function ui.getScrollX() end

---@return number
function ui.getScrollY() end

---@return number
function ui.getScrollMaxX() end

---@return number
function ui.getScrollMaxY() end

---@param scrollX number
---@param relative boolean? @Default value: `false`.
---@param smooth boolean? @Default value: `true`.
function ui.setScrollX(scrollX, relative, smooth) end

---@param scrollY number
---@param relative boolean? @Default value: `false`.
---@param smooth boolean? @Default value: `true`.
function ui.setScrollY(scrollY, relative, smooth) end

---Adjust scrolling amount to make last item visible. When using to make a default/current item visible, consider using ac.setItemDefaultFocus() instead.
---@param centerXRatio number? @0 for top of last item, 0.5 for vertical center of last item, 1 for bottom of last item. Default value: 0.5.
function ui.setScrollHereX(centerXRatio) end

---Adjust scrolling amount to make last item visible. When using to make a default/current item visible, consider using ac.setItemDefaultFocus() instead.
---@param centerYRatio number? @0 for top of last item, 0.5 for vertical center of last item, 1 for bottom of last item. Default value: 0.5.
function ui.setScrollHereY(centerYRatio) end

---Is current window hovered (and typically not blocked by a popup/modal).
---@param flags ui.HoveredFlags? @Default value: `ImGuiHoveredFlags_None`.
---@return boolean
function ui.windowHovered(flags) end

---Is current window focused (or its root/child, depending on flags).
---@param flags ui.FocusedFlags? @Default value: `ImGuiFocusedFlags_None`.
---@return boolean
function ui.windowFocused(flags) end

---Returns `true` if mouse currently is either used by one of IMGUI controls (like dragging something) or if it hovers any of windows. If that’s the case and
---your script reacts to clicks on the scene, for example, better to skip that frame.
---@return boolean
function ui.mouseBusy() end

---Did mouse button clicked (went from not down to down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseClicked(mouseButton) end

---Did mouse button double-clicked. A double-click returns `false` in `ui.mouseClicked()`.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseDoubleClicked(mouseButton) end

---Did mouse button released (went from down to not down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseReleased(mouseButton) end

---Is mouse button held.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseDown(mouseButton) end

---Returns mouse cursor position on a screen. To get mouse position within current window, use `ui.mouseLocalPos()`.
---@return vec2 @Mouse cursor position in pixels, or (-1, -1) if mouse is not available.
function ui.mousePos() end

---Returns mouse cursor position relative to current app/window. To get mouse position within screen window, use `ui.mousePos()`.
---@return vec2 @Mouse cursor position in pixels, or (-1, -1) if mouse is not available.
function ui.mouseLocalPos() end

---Get upper-left bounding rectangle of the last item (window space).
---@return vec2
function ui.itemRectMin() end

---Get lower-right bounding rectangle of the last item (window space).
---@return vec2
function ui.itemRectMax() end

---Time since last frame of current UI context.
---@return number
function ui.deltaTime() end

---Get size of last item.
---@return vec2
function ui.itemRectSize() end

---Returns mouse cursor position delta comparing to previous frame.
---@return vec2
function ui.mouseDelta() end

---Returns mouse wheel movement (1 unit scrolls 5 text lines).
---@return number
function ui.mouseWheel() end

---Returns position of current window in screen-space/texture-space (`ui.beginChild()` returns a new window).
---@return vec2
function ui.windowPos() end

---Returns size of current window.
---@return vec2
function ui.windowSize() end

---Size of contents/scrollable client area (calculated from the extents reach of the cursor) from previous frame. Does not include window decoration or window padding.
---@return vec2
function ui.windowContentSize() end

---Size of contents/scrollable client area explicitly request by the user via `ui.setNextWindowContentSize()`.
---@return vec2
function ui.windowContentExplicitSize() end

---Set next window content size (scrollable client area, which enforce the range of scrollbars). Not including window decorations (title bar, menu bar, etc.) nor WindowPadding. Set an axis to 0 to leave it automatic. Call before `ui.beginChild()`.
---@param size vec2
function ui.setNextWindowContentSize(size) end

---Is key being held.
---@param keyIndex ui.KeyIndex
---@return boolean
function ui.keyboardButtonDown(keyIndex) end

---Was key pressed (went from `not down` to `down`). If `with_repeat` is true, uses configured repeat delay and rate.
---@param keyIndex ui.KeyIndex
---@param withRepeat boolean? @Default value: `true`.
---@return boolean
function ui.keyboardButtonPressed(keyIndex, withRepeat) end

---Was key released (went from `down` to `not down`).
---@param keyIndex ui.KeyIndex
---@return boolean
function ui.keyboardButtonReleased(keyIndex) end

---Simulate key being pressed (affects current IMGUI context only).
---@param keyIndex ui.KeyIndex
function ui.setKeyboardButtonDown(keyIndex) end

---Add input character for currently active text input.
---@param keyIndex ui.KeyIndex
function ui.addInputCharacter(keyIndex) end

---Clear input character for currently active text input.
function ui.clearInputCharacters() end

---Provides access to few buttons with certain UI roles.
---@param keyCode ui.Key
---@return boolean
function ui.keyPressed(keyCode) end

---Map a button with certain UI role to regular key index.
---@param keyCode ui.Key
---@return ui.KeyIndex
function ui.getKeyIndex(keyCode) end

---Returns true if Ctrl is pressed, but Shift, Alt and Super/Win are depressed.
---@return boolean
function ui.hotkeyCtrl() end

---Returns true if Alt is pressed, but Ctrl, Shift and Super/Win are depressed.
---@return boolean
function ui.hotkeyAlt() end

---Returns true if Shift is pressed, but Ctrl, Alt and Super/Win are depressed.
---@return boolean
function ui.hotkeyShift() end

---Adds modifiers to how IMGUI renders textures (including icons, any UI element, all texts, so use carefully and don’t forget
---to reset values to default with `ui.resetShadingOffset()` or by passing default arguments or no arguments here). Modifiers
---act like simple multiply-and-add adjustment, first value in pair acts like multiplier, second acts like addition (or subtraction)
---value. First pair affects RGB channels, second is for alpha. There are also special combinations:
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = 0: use texture RGB for color (multiplied by shape color) and green texture channel for alpha;
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = 1: use shape color for color and red texture channel for alpha;
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = -1: use shape color for color and inverse of red texture channel for alpha.
---@param brightness number? @Default value: 1.
---@param offset number? @Default value: 0.
---@param alphaMult number? @Default value: 1.
---@param alphaOffset number? @Default value: 0.
function ui.setShadingOffset(brightness, offset, alphaMult, alphaOffset) end

---Resets texture sampling modifiers.
function ui.resetShadingOffset() end

---Draw text using AC font (which should previously set with `ui.pushACFont()`.
---@param text string
---@param letter vec2
---@param marginOffset number? @Default value: 0.
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param lineSpace number? @Default value: 0.
---@param monospace boolean? @Default value: `true`.
function ui.acText(text, letter, marginOffset, color, lineSpace, monospace) end

---Calculate size of text using AC font (which should previously set with `ui.pushACFont()`.
---@param text string
---@param letter vec2
---@param marginOffset number? @Default value: 0.
---@param lineSpace number? @Default value: 0.
---@param monospace boolean? @Default value: `true`.
---@return vec2
function ui.calculateACTextSize(text, letter, marginOffset, lineSpace, monospace) end

---Pushes new AC font on stack. After you finished using it, don’t forget to use `ui.popACFont()`. Fonts will be search for
---in “content/fonts”, as well as in script’s folder.
---@param name string
function ui.pushACFont(name) end

---Pops previously pushed font from stack. Note: font will not be unloaded or anything like that, feel free to use it as much as you need.
function ui.popACFont() end

---Adds new TTF font to the stack to be used for drawing DWrite text later. Fonts are taken from “content/fonts” and “extension/fonts”, but scripts
---can also use their own TTF files. To do so, use `'Font Name:path/to/file.ttf'` or `'Font Name:path/to/directory'`, path can be absolute, relative
---to script folder or AC root folder. Font name can also use styling attributes, such as `Weight=Thin`, `Style=Italic` or `Stretch=Condensed`, listed
---at the end after a “;” like so:
---```
---ui.pushDWriteFont('My Font:myfont.ttf;Weight=Bold;Style=Oblique;Stretch=Expanded')
---```
---To make things simpler, you can also use `ac.DWriteFont` helper, it provides nice methods to set attributes.
---
---If you need to use a standard system font, set “@System” as font path: it would use faster working system fonts collection.
---@param name string? @Font name, or `'name:path.ttf'`, with optional styling attributes. You can use `ac.DWriteFont` helper here. Default value: 'Segoe UI'.
function ui.pushDWriteFont(name) end

---Removes latest TTF font from the stack.
function ui.popDWriteFont() end

---Calculate size of text using current IMGUI font.
---@param text string
---@param wrapWidth number? @Set to positive value of pixels to enable text wrapping. Default value: -1.
---@return vec2
function ui.measureText(text, wrapWidth) end

---Calculate size of text using TTF font. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param wrapWidth number? @Set to positive value of pixels to enable text wrapping. Default value: -1.
---@return vec2
function ui.measureDWriteText(text, fontSize, wrapWidth) end

---Draws some text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteText(text, fontSize, color) end

---Draws wrapped text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteTextWrapped(text, fontSize, color) end

---Draws some aligned text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param horizontalAligment ui.Alignment? @Ac.Alignment.Start for left, ac.Alignment.Center for middle, ac.Alignment.End for right. Default value: `alignment::center`.
---@param verticalAlignment ui.Alignment? @Ac.Alignment.Start for top, ac.Alignment.Center for middle, ac.Alignment.End for bottom. Default value: `alignment::center`.
---@param size vec2? @Set to 0 to use remaining space, set to negative value to use it as margin (positive) from remaining space. Default value: `vec2(0, 0)`.
---@param allowWordWrapping boolean? @Default value: `false`.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteTextAligned(text, fontSize, horizontalAligment, verticalAlignment, size, allowWordWrapping, color) end

function ui.popID() end

---@return integer
function ui.getLastID() end

---@return integer
function ui.getActiveID() end

---@return integer
function ui.getFocusID() end

---@return integer
function ui.getHoveredID() end

function ui.clearActiveID() end

---@param id integer
function ui.activateItem(id) end

---Returns a number associated with current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param defaultValue number? @Default value: 0.
---@return number
function ui.loadStoredNumber(id, defaultValue) end

---Returns a boolean value associated with current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param defaultValue boolean? @Default value: `false`.
---@return boolean
function ui.loadStoredBool(id, defaultValue) end

---Stores a number in current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param value number? @Default value: 0.
function ui.storeNumber(id, value) end

---Stores a boolean value in current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param value boolean? @Default value: `false`.
function ui.storeBool(id, value) end

---@param columns integer? @Default value: 1.
---@param border boolean? @Default value: `true`.
---@param id string|nil @Default value: `nil`.
function ui.columns(columns, border, id) end

function ui.nextColumn() end

---@param columnIndex integer
---@param width number
function ui.setColumnWidth(columnIndex, width) end

---Copyable text.
---@param label string
function ui.copyable(label) end

---Simple button.
--- @overload fun(label: string, flags: ui.ButtonFlags)
---@param label string
---@param size vec2? @Default value: `vec2(0, 0)`.
---@param flags ui.ButtonFlags? @Default value: `ImGuiButtonFlags_None`.
---@return boolean
function ui.button(label, size, flags) end

---Button without frame padding to easily embed within text.
---@param label string
---@return boolean
function ui.smallButton(label) end

---Button behavior without the visuals, frequently useful to build custom behaviors using the public API (along with `ui.itemActive()`, `ui.itemHovered()`, etc.)
---@param label string
---@param size vec2
---@return boolean
function ui.invisibleButton(label, size) end

---Add a dummy item of given size. unlike `ui.invisibleButton()`, dummy won’t take the mouse click or be navigable into.
---@param size vec2
function ui.dummy(size) end

---Square button with an arrow shape.
---@param strID string
---@param dir ui.Direction
---@param size vec2? @Default value: `vec2(0, 0)`.
---@param flags ui.ButtonFlags? @Default value: `ImGuiButtonFlags_None`.
---@return boolean
function ui.arrowButton(strID, dir, size, flags) end

---Draw a small circle and keep the cursor on the same line.
function ui.bullet() end

---Separator, generally horizontal. Inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
function ui.separator() end

---Checkbox. Pass `refbool` for current value, or just pass a regular `boolean` and switch state yourself if
---function would return `true`.
---```
---if ui.checkbox('My checkbox', myFlag) then
---  myFlag = not myFlag
---end
---```
---@param label string
---@param checked boolean|refbool|nil
---@return boolean @Returns `true` if checkbox was clicked.
function ui.checkbox(label, checked) end

---@param label string
---@param checked boolean|refbool|nil
---@return boolean
function ui.radioButton(label, checked) end

---@param fraction number
---@param size vec2? @Default value: `vec2(0, 0)`.
---@param overlay string|nil @Default value: `nil`.
function ui.progressBar(fraction, size, overlay) end

---@param width number
function ui.setNextItemWidth(width) end

---It’s safer to use `ui.combo()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param previewValue string
---@param flags ui.ComboFlags? @Default value: `ImGuiComboFlags_None`.
---@return boolean
function ui.beginCombo(label, previewValue, flags) end

---@param label string
---@param selected boolean|refbool|nil
---@param flags ui.SelectableFlags? @Default value: `ImGuiSelectableFlags_None`.
---@param size vec2? @Default value: `vec2(0, 0)`.
---@return boolean
function ui.selectable(label, selected, flags, size) end

function ui.endCombo() end

---It’s safer to use `ui.childWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param id string
---@param size vec2? @Default value: `vec2(0, 0)`.
---@param border boolean? @Default value: `false`.
---@param flags ui.WindowFlags? @Default value: `ImGuiWindowFlags_NoBackground`.
---@return boolean
function ui.beginChild(id, size, border, flags) end

function ui.endChild() end

---It’s safer to use `ui.tabBar()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param id string
---@param flags ui.TabBarFlags? @Default value: `ImGuiTabBarFlags_None`.
---@return boolean
function ui.beginTabBar(id, flags) end

function ui.endTabBar() end

---It’s safer to use `ui.tabBarItem()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param flags ui.TabItemFlags? @Default value: `ImGuiTabItemFlags_None`.
---@return boolean
function ui.beginTabItem(label, flags) end

function ui.endTabItem() end

---It’s safer to use `ui.treeNode()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param flags ui.TreeNodeFlags? @Default value: `ImGuiTreeNodeFlags_Framed`.
---@return boolean
function ui.beginTreeNode(label, flags) end

function ui.endTreeNode() end

---It’s safer to use `ui.itemPopup()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param id string
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Right`.
---@return boolean
function ui.beginPopupContextItem(id, mouseButton) end

function ui.endPopup() end

---It’s safer to use `ui.tooltip()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason. If you
---just need to render some text in a tooltip, use `ui.setTooltip()` instead.
---@param padding vec2? @Default value: `vec2(20, 8)`.
function ui.beginTooltip(padding) end

function ui.endTooltip() end

---@param text string
function ui.header(text) end

---@param text string
function ui.bulletText(text) end

---@param tooltip string
function ui.setTooltip(tooltip) end

---Is the last item hovered and usable, aka not blocked by a popup, etc.
---@param flags ui.HoveredFlags? @Default value: `ImGuiHoveredFlags_None`.
---@return boolean
function ui.itemHovered(flags) end

---Is the last item clicked (e.g. button/node just clicked on), same as `ui.mouseClicked(mouseButton) and ui.itemHovered()`
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.itemClicked(mouseButton) end

---Is the last item active (e.g. button being held, text field being edited). This will continuously return true while holding mouse button on an item. Items that don’t interact will always return false)
---@return boolean
function ui.itemActive() end

---Is the last item focused for keyboard/gamepad navigation.
---@return boolean
function ui.itemFocused() end

---Is the last item visible (items may be out of sight because of clipping/scrolling).
---@return boolean
function ui.itemVisible() end

---Did the last item modify its underlying value this frame, or was pressed. This is generally the same as the return value of many widgets.
---@return boolean
function ui.itemEdited() end

---Was the last item just made active (item was previously inactive).
---@return boolean
function ui.itemActivated() end

---Was the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that requires continuous editing.
---@return boolean
function ui.itemDeactivated() end

---Was the last item just made inactive and made a value change when it was active (e.g. slider moved). Useful for Undo/Redo patterns with widgets that requires continuous editing. Note: you may get false positives (some widgets such as combo/selectable will return true even when clicking an already selected item).
---@return boolean
function ui.itemDeactivatedAfterEdit() end

---Is any item hovered.
---@return boolean
function ui.anyItemHovered() end

---Is any item active.
---@return boolean
function ui.anyItemActive() end

---Is any item focused.
---@return boolean
function ui.anyItemFocused() end

---Get upper-left bounding rectangle of the last item (screen space).
---@deprecated
---@return vec2
function ui.getItemRectMin() end

---Get lower-right bounding rectangle of the last item (screen space).
---@deprecated
---@return vec2
function ui.getItemRectMax() end

---Get size of last item.
---@deprecated
---@return vec2
function ui.getItemRectSize() end

---Allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
function ui.setItemAllowOverlap() end

---Was the last item selection (`ui.selectable()`, `ui.treeNode()`, etc.) toggled
---@return boolean
function ui.itemToggledSelection() end

---Unlike `ui.drawImage()`, this one adds an image as an item to current cursor position and moves the cursor. Also allows
---to interact with an image with functions like `ui.itemHovered()`. You can do the same with `ui.drawImage()`, just use
---`ui.getCursor()` for `p1`, `ui.getCursor() + size` for `p2` and `ui.dummy()` for interaction.
---@overload fun(filename: string, size: vec2, color: rgbm, keepAspectRatio: boolean)
---@overload fun(filename: string, size: vec2, keepAspectRatio: boolean)
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param size vec2 @Size of resulting image in pixels.
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param borderColor rgbm|nil @Optional 1-pixel wide border around image. Default value: `nil`.
---@param uv1 vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.
---@param keepAspectRatio boolean? @Set to `true` to stretch image to fit given size, making sure it would not get distorted. Default value: `false`.
function ui.image(filename, size, color, borderColor, uv1, uv2, keepAspectRatio) end

---Adds a button with an image on it. If image is missing or loading (if it’s remote or asyncronous loading is enabled),
---button would still appear, but without an image.
---@overload fun(filename: string, size: vec2, color: rgbm, framePadding: number, keepAspectRatio: boolean)
---@overload fun(filename: string, size: vec2, framePadding: number, keepAspectRatio: boolean)
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param size vec2 @Size of resulting image in pixels.
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param bgColor rgbm|nil @Optional background color for the image (transparent if not set). Default value: `nil`.
---@param uv1 vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 vec2? @Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.
---@param framePadding number? @If -1, uses frame padding from style. If 0, there is no padding. If above zero, it’s used as actual padding value. Default value: -1.
---@param keepAspectRatio boolean? @Set to `true` to stretch image to fit given size, making sure it would not get distorted. Default value: `false`.
---@return boolean
function ui.imageButton(filename, size, color, bgColor, uv1, uv2, framePadding, keepAspectRatio) end

---Returns `true`, if an image is ready to be drawn. If image was not used before, starts its loading.
---
---Note: By default images from local files are loaded syncronously, use `ui.setAsynchronousImagesLoading(true)` function to change this behaviour.
---@param filename string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@return boolean
function ui.isImageReady(filename) end

---Activates synchronous loading for local images. By default local images are loaded syncronously, but by calling this function
---and passing `true` to it, they would start to load asyncronously from there, reducing possible stutters. Any remote images are loaded
---asyncronously no matter what.
---
---Note: for now, any image ever loaded would remain in RAM and video memory. Try not to load way too many things.
---@param value boolean? @Default value: `true`.
function ui.setAsynchronousImagesLoading(value) end

---Width of item given pushed settings and current cursor position. NOT necessarily the width of last item unlike most 'Item' functions.
---@return number
function ui.calcItemWidth() end

---Allow focusing using Tab/Shift+Tab, enabled by default but you can disable it for certain widgets.
---@param allowKeyboardFocus boolean|`true`|`false`
function ui.pushAllowKeyboardFocus(allowKeyboardFocus) end

---Removes last `ui.pushAllowKeyboardFocus()` modification.
function ui.popAllowKeyboardFocus() end

---In repeat mode, button functions return repeated true in a typematic manner.
---Note: you can call `ui.itemActive()` after any button to tell if the button is held in the current frame.
---@param repeatValue boolean|`true`|`false`
function ui.pushButtonRepeat(repeatValue) end

---Removes last `ui.pushButtonRepeat()` modification
function ui.popButtonRepeat() end

---Move content position toward the right.
---@param indentW number? @If 0, indent spacing from style will be used. Default value: 0.0.
function ui.indent(indentW) end

---Move content position back to the left.
---@param indentW number? @If 0, indent spacing from style will be used. Default value: 0.0.
function ui.unindent(indentW) end

---Initial cursor position in window coordinates.
---@return vec2
function ui.cursorStartPos() end

---Cursor position in absolute screen coordinates (within AC window or its UI in VR, but also affected by UI scale).
---@return vec2
function ui.cursorScreenPos() end

---Cursor position in absolute screen coordinates (within AC window or its UI in VR, but also affected by UI scale).
---@param pos vec2
function ui.setCursorScreenPos(pos) end

---Vertically align upcoming text baseline to frame padding so that it will align properly to regularly framed items (call if you have text on a line before a framed item).
function ui.alignTextToFramePadding() end

---Pretty much just font size.
---@return number
function ui.textLineHeight() end

---Returns font size and vertical item spacing (distance in pixels between 2 consecutive lines of text).
---@return number
function ui.textLineHeightWithSpacing() end

---Returns font size and frame padding.
---@return number
function ui.frameHeight() end

---Returns font size, frame padding and vertical item spacing (distance in pixels between 2 consecutive lines of framed widgets).
---@return number
function ui.frameHeightWithSpacing() end

---Get current font size (height in pixels) of current font with current scale applied.
---@return number
function ui.fontSize() end

---Get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API.
---@return vec2
function ui.fontWhitePixelUV() end

---Pushes new alpha value taking into account current style alpha, good for fading elements in case any parent elements could also fade.
---To revert change, use `ui.popStyleVar()`.
---@param alpha number
function ui.pushStyleVarAlpha(alpha) end

---Adjust scrolling amount to make given position visible. Generally `ui.cursorStartPos() + offset` to compute a valid position.
---@param localX number
---@param centerXRatio number? @Default value: 0.5.
function ui.setScrollFromPosX(localX, centerXRatio) end

---Adjust scrolling amount to make given position visible. Generally `ui.cursorStartPos() + offset` to compute a valid position.
---@param localY number
---@param centerYRatio number? @Default value: 0.5.
function ui.setScrollFromPosY(localY, centerYRatio) end

---Get current window width (shortcut for `ui.windowSize().x`)
---@return number
function ui.windowWidth() end

---Get current window height (shortcut for `ui.windowSize().y`)
---@return number
function ui.windowHeight() end

---If current window just been opened.
---@return boolean
function ui.isWindowAppearing() end

---Is current window collapsed.
---@return boolean
function ui.isWindowCollapsed() end

---Is current window focused (or its root/child, depending on flags).
---@param flags ui.FocusedFlags? @Default value: `ImGuiFocusedFlags_None`.
---@return boolean
function ui.isWindowFocused(flags) end

---Uses provided repeat rate/delay. Return a count, most often 0 or 1, but might be > 1 if RepeatRate is small enough that DeltaTime > RepeatRate
---@param keyIndex ui.KeyIndex
---@param repeatDelay number
---@param rate number
---@return integer
function ui.keyPressedAmount(keyIndex, repeatDelay, rate) end

---Is any mouse button held.
---@return boolean
function ui.isAnyMouseDown() end

---Did mouse button released (went from down to not down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.isMouseReleased(mouseButton) end

---Is mouse dragging. If `lockThreshold` < -1, uses io.MouseDraggingThreshold
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@param lockThreshold number? @Default value: -1.0.
---@return boolean
function ui.isMouseDragging(mouseButton, lockThreshold) end

---Retrieve backup of mouse position at the time of opening popup we have `ui.beginPopup()` into
---@return vec2
function ui.mousePosOnOpeningCurrentPopup() end

---Return the delta from the initial clicking position while the mouse button is pressed or was just released. This is locked and
---return 0 until the mouse moves past a distance threshold at least once.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@param lockThreshold number? @If below zero, default mouse dragging threshold will be used. Default value: -1.0.
---@return vec2
function ui.mouseDragDelta(mouseButton, lockThreshold) end

---Resets mouse drag delta.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
function ui.resetMouseDragDelta(mouseButton) end

---Get cursor type. Cursor type resets in with each new frame
---@return ui.MouseCursor
function ui.mouseCursor() end

---Set cursor type.
---@param type ui.MouseCursor
function ui.setMouseCursor(type) end

---Stops rest of Assetto Corsa from responding to keyboard events (key bindings, etc.), also sets `getUI().wantCaptureKeyboard` flag. Note:
--- if you writing a script reacting to general keyboard events, consider checking that flag to make sure IMGUI doesn’t have keyboard captured currently.
---@param wantCaptureKeyboardValue boolean? @Default value: `true`.
function ui.captureKeyboard(wantCaptureKeyboardValue) end

---Stops rest of Assetto Corsa from responding to mouse events, also sets `getUI().wantCaptureMouse` flag. Note:
--- if you writing a script reacting to general mouse events, consider checking that flag to make sure IMGUI doesn’t have mouse captured currently.
---@param wantCaptureMouseValue boolean? @Default value: `true`.
function ui.captureMouse(wantCaptureMouseValue) end

---Get text that is currently in clipboard.
---@return string
function ui.getClipboardText() end

---Set new text to clipboard.
---@param text string
function ui.setClipboardText(text) end

---Get global IMGUI time. Incremented by `dt` every frame.
---@return number
function ui.time() end

---Get global IMGUI frame count. Incremented by 1 every frame.
---@return integer
function ui.frameCount() end

---Open modal popup message with OK and Cancel buttons, return user choice via callback.
---@overload fun(title: string, msg: string, callback: function)
---@param title string
---@param msg string
---@param okText string @Optional label for OK button.
---@param cancelText string @Optional label for cancel button.
---@param okIconID ui.Icons @Optional icon for OK button.
---@param cancelIconID ui.Icons @Optional icon for cancel button.
---@param callback fun(okPressed: boolean)
function ui.modalPopup(title, msg, okText, cancelText, okIconID, cancelIconID, callback) end

---Open modal popup message with text input, OK and Cancel buttons, return user choice via callback.
---@overload fun(title: string, msg: string, defaultValue: string, callback: function)
---@param title string
---@param msg string
---@param defaultValue string
---@param okText string @Optional label for OK button.
---@param cancelText string @Optional label for cancel button.
---@param okIconID ui.Icons @Optional icon for OK button.
---@param cancelIconID ui.Icons @Optional icon for cancel button.
---@param callback fun(value: string|nil)
function ui.modalPrompt(title, msg, defaultValue, okText, cancelText, okIconID, cancelIconID, callback) end

---Projects world point onto a screen (taking into account UV scale unless second argument is set to `false`).
---@param pos vec3
---@param considerUiScale boolean? @Default value: `true`.
---@return vec2 @Returns vector with `inf` for values if point is outside of screen.
function ui.projectPoint(pos, considerUiScale) end

---If possible, unloads image from memory and VRAM. Doesn’t work with all types of images.
---@param filename string
---@return boolean @Returns `true` if file was unloaded successfully.
function ui.unloadImage(filename) end

---Teleports car to certain spawn point, invalidates current lap.
---@param carIndex integer
---@param spawnSet ac.SpawnSet
function physics.teleportCarTo(carIndex, spawnSet) end

---Sets car position and orientation and invalidates current lap time. Car will be aligned on track surface.
---@param carIndex integer
---@param pos vec3
---@param dir vec3
function physics.setCarPosition(carIndex, pos, dir) end

---Sets car velocity and invalidates current lap time.
---@param carIndex integer
---@param velocity vec3
function physics.setCarVelocity(carIndex, velocity) end

---Forces certain gear to engage. Might not work well for user car with H-shifter. Also, invalidates current lap time.
---@param carIndex integer @0-based car index.
---@param gearToEngage integer @-1 for reverse, 0 for neutral, etc.
function physics.engageGear(carIndex, gearToEngage) end

---Changes AI level. Use `ac.getCar(carIndex).aiLevel` to get current value.
---@param carIndex integer @0-based car index.
---@param level number @AI level from 0 to 1.
function physics.setAILevel(carIndex, level) end

---Changes AI aggression. Use `ac.getCar(carIndex).aiAggression` to get current value.
---@param carIndex integer @0-based car index.
---@param aggression number @AI aggression from 0 to 1.
function physics.setAIAggression(carIndex, aggression) end

---Limits AI throttle pedal.
---@param carIndex integer @0-based car index.
---@param limit number @0 for limit gas pedal to 0, 1 to remove limitation.
function physics.setAIThrottleLimit(carIndex, limit) end

---Limits AI top speed. Use `math.huge` (or just 1e9) to remove limitation.
---@param carIndex integer @0-based car index.
---@param limit number @Speed in km/h.
function physics.setAITopSpeed(carIndex, limit) end

---Sets horizontal offset along spline, can be used to get cars to drive further to the left or to the right. Actual offset
---will be limited by track width as well.
---@param carIndex integer @0-based car index.
---@param offset number
function physics.setAISplineOffset(carIndex, offset) end

---Changes extra AI grip (120% by default).
---@param carIndex integer @0-based car index.
---@param value number @Set to 1 for normal grip.
function physics.setExtraAIGrip(carIndex, value) end

---Activates or deactivates gentle stopping.
---@param carIndex integer @0-based car index.
---@param stop boolean? @Default value: `true`.
function physics.setGentleStop(carIndex, stop) end

---Forces fully engaged brakes for user car for given time. Invalidates lap. Subsequent calls override value set earlier.
---@param time number @Time in seconds; 0 to disable brakes forcing.
---@param brakingIntensity number? @Braking intensity, from 0 to 1. Default value: 1.
function physics.forceUserBrakesFor(time, brakingIntensity) end

---Forces fully engaged throttle pedal for user car for given time. Invalidates lap. Subsequent calls override value set earlier.
---@param time number @Time in seconds; 0 to disable brakes forcing.
---@param throttleIntensity number? @Braking intensity, from 0 to 1. Default value: 1.
function physics.forceUserThrottleFor(time, throttleIntensity) end

---Offsets steering angle.
---@param offset number
function physics.offsetUserSteering(offset) end

---Overrides steering angle.
---@param value number
---@param share number
function physics.overrideUserSteering(value, share) end

---Resets car state (repairs damage, resets fuel) and invalidates current lap.
---@param carIndex integer @0-based car index.
---@param fuelMult number? @Default value: 0.5.
function physics.resetCarState(carIndex, fuelMult) end

---Sets car fuel and invalidates current lap.
---@param carIndex integer @0-based car index.
---@param fuelLiters number @Amount of fuel in liters.
function physics.setCarFuel(carIndex, fuelLiters) end

---Disables input for user car, switches car to “parked” state.
---@param active boolean? @Default value: `true`.
function physics.setCarNoInput(active) end

---Activates or deactivates autopilot for user car. Invalidates lap.
---@param active boolean? @Default value: `true`.
function physics.setCarAutopilot(active) end

---Returns state of car controls user input. Works even if user car controls were deactivated or AI is controlling user car.
---@return physics.CarControls
function physics.getCarInputControls() end

---Reduces grip for some tyres of a certain car. Invalidates current lap. Could be used as a cheap way to simulate some things
---like ice.
---@param carIndex integer @0-based car index.
---@param wheels ac.Wheel @Wheels to affect.
---@param decrease number @0 for tyres to act as usual, 1 for tyres to lose all grip.
function physics.setGripDecrease(carIndex, wheels, decrease) end

---Blows up some tyres of a certain car. Invalidates current lap.
---@param carIndex integer @0-based car index.
---@param wheels ac.Wheel? @Wheels to affect. Default value: 15.
function physics.blowTyres(carIndex, wheels) end

---Sets tyre blankets and invalidates current lap. If set, they would keep tyres at optimal temperature until car would reach 10 km/h,
---and then they would be removed. If you need to set tyres temperature for a moving car, use `physics.setTyresTemperature()`
---(to get optimal tyre temperature, use `ac.getCar(N).wheels[0].tyreOptimumTemperature`.
---@param carIndex integer @0-based car index.
---@param wheels ac.Wheel? @Wheels to affect. Default value: 15.
---@param blanketActive boolean? @True to set tyre blankets, false to remove. Default value: `true`.
function physics.setTyresBlankets(carIndex, wheels, blanketActive) end

---Sets tyres temperature and invalidates current lap. To get optimal tyre temperature, use `ac.getCar(N).wheels[0].tyreOptimumTemperature`.
---@param carIndex integer @0-based car index.
---@param wheels ac.Wheel @Wheels to affect.
---@param temperature number @New tyres temperature in °C.
function physics.setTyresTemperature(carIndex, wheels, temperature) end

---Sets damage levels of a given car, invalidates lap.
---@param carIndex integer @0-based car index.
---@param bodyDamage vec4 @Damage for different sides in km/h.
function physics.setCarBodyDamage(carIndex, bodyDamage) end

---Sets damage level of the engine of a given car, invalidates lap.
---@param carIndex integer @0-based car index.
---@param engineLife number @Engine life left (1000 for new engine, breaks at 0).
function physics.setCarEngineLife(carIndex, engineLife) end

---Sets car ballast, invalidates current lap if ballast is negative.
---@param carIndex integer @0-based car index.
---@param ballast number @Ballast in kg.
function physics.setCarBallast(carIndex, ballast) end

---Sets car restrictor.
---@param carIndex integer @0-based car index.
---@param restrictor number @Restrictor value.
function physics.setCarRestrictor(carIndex, restrictor) end

---Enables and disables car collisions (wouldn’t affect disabled collisions in pits, more like an extra option to
--- further disable collisions). Invalidates lap.
---@param carIndex integer @0-based car index.
---@param active boolean|`true`|`false` @Set to `false` to disable collisions.
function physics.setCarCollisions(carIndex, active) end

---Allows and disallows car DRS. If DRS is already disallowed by track zones, wouldn’t override it, but allows to add more
--- conditions disallowing DRS further (FIA rules and all that). If DRS is already engaged, it’ll be disengaged. Does not
--- invalidate lap.
---@param carIndex integer @0-based car index.
---@param active boolean|`true`|`false` @Set to `false` to disallow use of DRS.
function physics.allowCarDRS(carIndex, active) end

---If DRS is present and available, activates or deactivates it. Does not invalidate lap.
---@param carIndex integer @0-based car index.
---@param active boolean|`true`|`false` @Set to `true` to activate or to `false` to deactivate DRS.
function physics.setCarDRS(carIndex, active) end

---Sets penalty for user car, invalidates current lap.
---@param penaltyType ac.PenaltyType @Type of penalty to apply.
---@param penaltyParam integer? @Penalty parameter (-1 for default value), actual role depends on penalty type. Default value: -1.
function physics.setCarPenalty(penaltyType, penaltyParam) end

---Stops car from sleeping, invalidates current lap.
---@param carIndex integer @0-based car index.
function physics.awakeCar(carIndex) end

---Adds force to a car, invalidates current lap.
---@param carIndex integer @0-based car index.
---@param position vec3 @Point of force application.
---@param posLocal boolean|`true`|`false` @If `true`, position is treated like position relative to car coordinates, otherwise as world position.
---@param force vec3 @Force vector in N.
---@param forceLocal boolean|`true`|`false` @If `true`, force is treated like vector relative to car coordinates, otherwise as world vector.
function physics.addForce(carIndex, position, posLocal, force, forceLocal) end

---Marks current lap as spoiled. Works only during the race
---@param carIndex integer
function physics.markLapAsSpoiled(carIndex) end

---Enables engine stalling (if RPM is below idling, torque would be added only if backspace is pressed). Use
---it together with `physics.setEngineRPM()` to shut off the engine.
---@param carIndex integer @0-based car index.
---@param value boolean? @Default value: `true`.
function physics.setEngineStallEnabled(carIndex, value) end

---Sets engine RPM.
---@param carIndex integer @0-based car index.
---@param rpm number
function physics.setEngineRPM(carIndex, rpm) end

---Sets name of a user, announces new name online to other clients. Could be used for some hot driver swapping.
---@param name string @First and last name separated by a space.
---@param nationCode ac.NationCode|nil @3 characters long nation code. If not set, current value is used. Default value: `nil`.
function physics.setDriverName(name, nationCode) end

---Sets name of a user’s team, announces new name online to other clients. Could be used for some hot driver swapping.
---@param team string @Team name.
function physics.setDriverTeam(team) end

---Overrides racing flag. Don’t forget to call `physics.overrideRacingFlag(ac.FlagType.None)` later to revert to original AC
---flag handling.
---@param flag ac.FlagType
function physics.overrideRacingFlag(flag) end

---Returns `true` if script can affect physics engine. If not, only `physics.raycastTrack()` is available.
---@return boolean
function physics.allowed() end

---Casts a ray from given position in a certain direction to check if it hits any physics surfaces. Returns distance to a hit,
---or -1 if there wasn’t any. Optionally can return contact point and normal too, if vectors in their place are passed.
---
---Note: smaller rays are faster to cast. Also, rays going straight down are slightly faster as well.
---@param pos vec3
---@param dir vec3
---@param length number
---@param point vec3|nil @Default value: `nil`.
---@param normal vec3|nil @Default value: `nil`.
---@return number
function physics.raycastTrack(pos, dir, length, point, normal) end

---Refreshes `ac.SimState.isAdmin` flag. Returns `false` if another check is already in progress.
---@return boolean
function ac.checkAdminPrivileges() end

---Sets or resets custom driver color for CSP chat app.
---@param carIndex integer @0-based car index.
---@param color rgbm|nil @Pass `nil` to reset the color. Default value: `nil`.
function ac.setDriverChatNameColor(carIndex, color) end

---Toggles visibility of driver model. Meant to be used for debugging, but could also be used for screenshots, for example.
---@param carIndex integer
---@param isVisible boolean|`true`|`false`
function ac.setDriverVisible(carIndex, isVisible) end

---Toggles driver door animation.
---@param carIndex integer
---@param isOpen boolean|`true`|`false`
function ac.setDriverDoorOpen(carIndex, isOpen) end

---Sets custom track condition input.
---@param key string
---@param value number
function ac.setTrackCondition(key, value) end

---Sets current camera mode.
---@param mode ac.CameraMode
function ac.setCurrentCamera(mode) end

---Sets current drivable camera mode.
---@param mode ac.DrivableCamera
function ac.setCurrentDrivableCamera(mode) end

---Sets current car camera index.
---@param mode integer @0-based index of car camera.
function ac.setCurrentCarCamera(mode) end

---Sets current track cameras set.
---@param set integer @0-based index of track cameras set (sim state has upper bound).
function ac.setCurrentTrackCamera(set) end

function ac.recenterVR() end

---Focus on a certain car.
---@param index integer @0-based car index.
function ac.focusCar(index) end

---Restart Assetto Corsa (shut it down, but before that, add a flag to “race.ini” telling launcher to restart simulation).
---@param raceIni string|nil @Optional INI data to merge with race.ini. Default value: `nil`.
function ac.restartAssettoCorsa(raceIni) end

---Shutdown Assetto Corsa.
function ac.shutdownAssettoCorsa() end

---Sends a new chat message.
---@param command string
---@return boolean @Returns `false` if message couldn’t be sent (trying to send too often, or not online).
function ac.sendChatMessage(command) end

---Sets a callback which will be called each time a new chat message arrives. Return `true` from callback to handle chat message
---and stop it from showing in chat apps.
---
---Second argument in callback stores car ID of a car that sent the message, or -1 if message comes from server.
---@param callback fun(message: string, senderCarIndex: integer, senderSessionID: integer): boolean @Callback which will be called each time new message arrives.
---@return ac.Disposable
function ac.onChatMessage(callback) end

---@param reverbValue number
function ac.setReverbValue(reverbValue) end

---Moves free camera to a certain position. Note: if you want to control camera fully, consider grabbing camera instead.
---@param pos vec3
function ac.setCameraPosition(pos) end

---Orients free camera. Note: if you want to control camera fully, consider grabbing camera instead.
---@param look vec3
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
function ac.setCameraDirection(look, up) end

---Sets FOV of a free camera. Note: if you want to control camera fully, consider grabbing camera instead.
---@param fov number @Value in degrees.
function ac.setCameraFOV(fov) end

---Sets exposure of a free camera. Note: if you want to control camera fully, consider grabbing camera instead.
---@param exposure number
function ac.setCameraExposure(exposure) end

---Sets DOF distance of a free camera. Note: if you want to control camera fully, consider grabbing camera instead.
---@param distance number @Value in meters, or 0 to disable DOF.
function ac.setCameraDOF(distance) end

---Pauses or un-pauses file system monitoring used for live reloading. Might be useful to pause it if you’re about to update a lot of configs, for example.
---@param pause boolean|`true`|`false`
function ac.pauseFilesWatching(pause) end

---Enables and disables lights debugging outlines. Parameters can be used to tune which lights would generate those outlines.
---@param filter string
---@param count integer
---@param mode ac.LightsDebugMode
---@param distance number? @Default value: 100.
function ac.debugLights(filter, count, mode, distance) end

---@param appName string
---@return boolean
function ac.isPythonAppActive(appName) end

---@param appName string
---@return boolean
function ac.reloadPythonApp(appName) end

---Resets car back to the track. Available in few basic modes in offline only (such as practice with a single car), invalidates lap.
function ac.resetCar() end

---Resets car back to the track and moves it a bit back. Available in few basic modes in offline only (such as practice with a single car), invalidates lap.
function ac.takeAStepBack() end

---Sets current time multiplier used by WeatherFX. Only affects single-player races.
---@param multiplier number
function ac.setWeatherTimeMultiplier(multiplier) end

---Sets current time offset for WeatherFX for smooth transition between different points in time (mostly for debugging).
---@param offset number
function ac.setWeatherTimeOffset(offset) end

---Sets current VAO mode, meant to be used for debugging purposes only.
---@param mode ac.VAODebugMode
function ac.setVAOMode(mode) end

---Gets current VAO mode, meant to be used for debugging purposes only.
---@return ac.VAODebugMode
function ac.getVAOMode() end

---Sets audio volume for given channel, value from 0 to 1. If channel is not recognized, does nothing.
---@overload fun(value: number)
---@param audioChannelKey ac.AudioChannel
---@param value number @Value from 0 to 1.
function ac.setAudioVolume(audioChannelKey, value) end

---Sets index of current wiper speed. To get current speed or number of available speeds, check `ac.StateCar`.
---@param carIndex integer
---@param wiperSpeed integer @Wiper speed index from 0 (disabled) to `ac.StateCar.wiperModes` (excluding).
function ac.setWiperSpeed(carIndex, wiperSpeed) end

---Marks current lap done by player as spoiled. Works only during the race
function ac.markLapAsSpoiled() end

---Sets track world coordinates in degrees.
---@param coords vec2 @X for lattitude, Y for longitude.
function ac.setTrackCoordinatesDeg(coords) end

---Sets timezone offset for the track in seconds. Be careful: unlike with configs, this method does not have any coordinate-related sanity checks.
---@param offset number @Offset in seconds (with DST offset added if necessary).
function ac.setTrackTimezoneOffset(offset) end

---Sets index of a current replay frame.
---@param frameIndex integer
---@param playCounter number @Transition between frames, from 0 to 1.
function ac.setReplayPosition(frameIndex, playCounter) end

---Executes command in AC console.
---@param command string
function ac.consoleExecute(command) end

---Sets a callback which will be called each time a new command is entered in AC console. If callback would return `true`, AC wouldn’t process
---command (return it if your script recognizes command to stop further processing).
---@param callback fun(command: string): boolean @Callback which will be called each time user enters new command.
---@return ac.Disposable
function ac.onConsoleInput(callback) end

---Sets a callback which will be called each frame when computing overall audio volume level. Callback returns a number which is used as volume multiplier.
---Use this function to fade out volume for one reason or another.
---@param callback fun(): number @Callback which will be called each time user enters new command.
---@return ac.Disposable
function ac.onAudioVolumeCalculation(callback) end

---Reload control settings.
function ac.reloadControlSettings() end

---Tries to start the race (pretty much, just to press Start button in pits menu).
---@return boolean @Returns `true` if started successfully.
function ac.tryToStart() end

---Pauses or unpauses simulation (if possible; for example, it wouldn’t be paused online with moving car or when displaying results).
---@param active boolean|`true`|`false`
---@return boolean @Returns `true` if paused successfully.
function ac.tryToPause(active) end

---Changes FFB gain. Unlike `ac.setCarFFB()` in Python apps, this one takes an absolute value, not a relative offset. To get current FFB multiplier,
---use `ac.getCar(0).ffbMultiplier`.
---@param multiplier number @1 for regular 100% FFB gain.
function ac.setFFBMultiplier(multiplier) end

---Use `ac.setFirstPersonCameraFOV()`
---@deprecated.
---@param fovDeg number
function ac.setOnboardCameraFOV(fovDeg) end

---Use `ac.resetFirstPersonCameraFOV()`
---@deprecated.
function ac.resetOnboardCameraFOV() end

---Changes FOV for first person camera. To get current value, use `ac.getSim().firstPersonFOV`.
---@param fovDeg number
function ac.setFirstPersonCameraFOV(fovDeg) end

---Resets FOV for first person camera to 56° (which is a default, but actual value is loaded from “assettocorsa/cfg/camera_onboard.ini”).
---To get current value, use `ac.getSim().firstPersonFOV`.
function ac.resetFirstPersonCameraFOV() end

---Gets onboard camera parameters for a specific car.
---@param carIndex integer
---@return ac.SeatParams
function ac.getOnboardCameraParams(carIndex) end

---Gets default onboard camera parameters for a specific car (loading them from “car.ini” from car data).
---@param carIndex integer
---@return ac.SeatParams
function ac.getOnboardCameraDefaultParams(carIndex) end

---Sets onboard camera parameters for a specific car. Optional saving works for the first car only.
---@param carIndex integer
---@param params ac.SeatParams
---@param save boolean? @If `true`, new values will be saved in “view.ini” in “Documents\AC\cfg\cars” a few seconds after a call, otherwise default camera positioning app will get a “Save needed” label. Default value: `true`.
function ac.setOnboardCameraParams(carIndex, params, save) end

---Returns `true` if current camera parameters need saving (when default camera positioning app shows a “Save needed” label).
---@return boolean
function ac.areOnboardCameraParamsNeedSaving() end

---Runs asyncronously.
---@param filename string|nil @If not set, default path will be used. Default value: `nil`.
function ac.makeScreenshot(filename) end

---Returns `true` if AI spline recorder is present and ready to do some recording.
---@return boolean
function ac.isAISplineRecorderPresent() end

---@return boolean
function ac.isAISplineRecorderActive() end

---@return boolean
function ac.isAISplineRecorderRecordingPitLane() end

---@return integer
function ac.getAISplineRecordedFrames() end

---@param recordPitLane boolean? @Default value: `false`.
function ac.startAISplineRecorder(recordPitLane) end

---@param saveResult boolean|`true`|`false`
---@param callback nil|fun(err: string)
function ac.stopAISplineRecorder(saveResult, callback) end

---Sets intensity of a heat shimmer zone with a given key. Returns `false` if there is no zone with such key.
---@param key integer
---@param intensity number
---@return boolean
function ac.setHeatShimmerIntensity(key, intensity) end

---@param mode integer
function ac.setABS(mode) end

---@param mode integer
function ac.setTC(mode) end

---@param turboIndex integer
---@return boolean
function ac.isTurboWastegateAdjustable(turboIndex) end

---@param wastegate number
---@param turboIndex integer? @Default value: -1.
function ac.setTurboWastegate(wastegate, turboIndex) end

---@param balance number
function ac.setBrakeBias(balance) end

---@param settingIndex integer
function ac.setEngineBrakeSetting(settingIndex) end

---@param state boolean|`true`|`false`
function ac.setDRS(state) end

---@param state boolean|`true`|`false`
function ac.setKERS(state) end

---@param charging boolean|`true`|`false`
function ac.setMGUHCharging(charging) end

---@param level integer
function ac.setMGUKDelivery(level) end

---@param level integer
function ac.setMGUKRecovery(level) end

function ac.switchToNeutralGear() end

---@param active boolean|`true`|`false`
function ac.setHeadlights(active) end

---@param active boolean|`true`|`false`
function ac.setHighBeams(active) end

---@param index integer
---@param value boolean|`true`|`false`
function ac.setExtraSwitch(index, value) end

---Get number of Real Mirror mirrors in a car (for car scripts, associated car, for apps and tools — player’s car). If Real
---Mirrors are disabled or not active for that car, returns -1.
---@return integer
function ac.getRealMirrorCount() end

---@param mirrorIndex integer @0-based mirror index (leftmost mirror is 0, the first one to right of it is 1 and so on).
---@param min vec3
---@param max vec3
---@return boolean
function ac.getRealMirrorAABB(mirrorIndex, min, max) end

---Updates mirror settings for a given Real Mirror mirror (for car scripts, associated car, for apps and tools — player’s car). Easiest way is to use
---it in combination with `ac.getRealMirrorParams()`:
--- ```
--- local params = ac.getRealMirrorParams()
--- params.fov = params.fov + 1
--- ac.setRealMirrorParams(params.fov)
--- ```
---
--- Updated settings will be written onto disk a few seconds after updated values have applied (if they’re different from current values).
---@param mirrorIndex integer @0-based mirror index (leftmost mirror is 0, the first one to right of it is 1 and so on).
---@param params ac.RealMirrorParams @New params to apply.
function ac.setRealMirrorParams(mirrorIndex, params) end

---@return vec4
function ac.iconColor() end

---Teleports car to a point defined by a server. Available online and only with servers with custom teleport destinations. Usual restrictions still
---apply. Meant for creating custom UI for that function.
---
---Use `ac.INIConfig.onlineExtras()` to get server config and parse destinations from there.
---@param pointIndex integer @0-based index.
---@return boolean @Returns `false` if there is no such point or it can’t be used as destination at the moment (for example, if there is already another car there).
function ac.teleportToServerPoint(pointIndex) end

---Checks if it’s possible to teleport to a custom server teleport destination. Meant for creating custom UI for that function.
---
---Use `ac.INIConfig.onlineExtras()` to get server config and parse destinations from there.
---@param pointIndex integer @0-based index.
---@return boolean
function ac.canTeleportToServerPoint(pointIndex) end

---Returns `true` if window with given ID is opened.
---@param windowID string
---@return boolean
function ac.isWindowOpen(windowID) end

---Returns `true` if window with given ID is in collapse state.
---@param windowID string
---@return boolean
function ac.isWindowCollapsed(windowID) end

---Returns `true` if window with given ID is pinned.
---@param windowID string
---@return boolean
function ac.isWindowPinned(windowID) end

---Opens or closes a window.
---@param windowID string
---@param opened boolean|`true`|`false`
function ac.setWindowOpen(windowID, opened) end

---Sets window title.
---@param windowID string
---@param title string|nil @If `nil`, restores original title. Default value: `nil`.
function ac.setWindowTitle(windowID, title) end

---Adds notifications counter to a window for something like amount of unread messages. Make sure to set it back to 0 when things have been seen.
---@param windowID string
---@param counter integer
function ac.setWindowNotificationCounter(windowID, counter) end

---If current window fades (has “FADING” flag), this value would store fading value. If background is fully opaque, value is 0.
---@return number
function ac.windowFading() end

---Fully unloads and terminates current app if possible. Execution will continue after this function, unloading will be attempted in the next frame.
---Only apps with no visible windows can be unloaded.
function ac.unloadApp() end

---Forces window with “FADING” flag to fade in even if it’s not currently hovered by a cursor or focused.
function ac.forceFadingIn() end

---@param active boolean|`true`|`false`
function ac.redirectVirtualMirror(active) end

---@param active boolean|`true`|`false`
function ac.redirectDamageDisplayer(active) end

---@param active boolean|`true`|`false`
function ac.redirectFuelWarningIndicator(active) end

---@return boolean
function ac.isSetupAvailableToEdit() end

---@param setupValueID string
---@param fallbackValue integer? @Default value: 0.
---@return integer
function ac.getSetupSpinnerValue(setupValueID, fallbackValue) end

---@param setupValueID string
---@param value integer
---@return boolean
function ac.setSetupSpinnerValue(setupValueID, value) end

---Refreshes list of setups. Any listeners set with `ac.onSetupsListRefresh()` will be called as well.
---@return boolean
function ac.refreshSetups() end

---Saves current setup into a file. If successful, refreshes setups list and calls any listeners set with `ac.onSetupsListRefresh()` as well.
---@param setupName string @Absolute path, or path relative to “Documents\Assetto Corsa\setups\<car ID>”.
---@return boolean
function ac.saveCurrentSetup(setupName) end

---Loads car setup from a file. Works only from setup menu, and only if setup is not fixed.
---@param setupName string @Absolute path, or path relative to “Documents\Assetto Corsa\setups\<car ID>”.
---@return boolean
function ac.loadSetup(setupName) end

---Resets car setup to default values. Works only from setup menu, and only if setup is not fixed.
---@param setupName string @Absolute path, or path relative to “Documents\Assetto Corsa\setups\<car ID>”.
---@return boolean
function ac.resetSetupToDefault(setupName) end

---Sets a callback which will be called when list of setups changes.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onSetupsListRefresh(callback) end

---Move mouse to a certain position.
---@param posPixels vec2 @New mouse cursor position in pixels relative to AC window.
function ac.setMousePosition(posPixels) end

---Can be used for simulating mouse clicks.
---@param isDown boolean|`true`|`false`
function ac.setMouseLeftButtonDown(isDown) end

---Can be used for simulating mouse wheel.
---@param scroll number
function ac.setMouseWheel(scroll) end
--[[ ac_apps.lua ]]

---Draw virtual mirror.
---@param pos vec2
---@param size vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawVirtualMirror(pos, size, color) end

---Collect information about available spinners in setup menu. Names match section names of setup INI files. Value `label` might contain localized setup items.
---@return {name: string, label: string, min: integer, max: integer, step: integer, value: integer, readOnly: boolean, units: string?, items: string[]?, defaultValue: integer?, showClicksMode: integer?}[]
function ac.getSetupSpinners() end

---@class ScriptData
---@single-instance
script = {}

---Called each frame.
---@param dt number @Time passed since last `update()` call, in seconds.
function script.update(dt) end

--[[ common/ac_audio.lua ]]

---Create a new audio event from previously loaded soundbank.
---@param eventName string @Event name, for example, `'/cars/lada_revolution/door'` (leading “/” or “event:” prefix are optional).
---@param reverbResponse boolean|`true`|`false` @Set to true if audio event should be affected by reverb in tunnels and such.
---@return ac.AudioEvent
function ac.AudioEvent(eventName, reverbResponse) end

---Create a new audio event from a file. Consequent calls with the same parameters would reuse previously loaded audio file.
---@param params {filename: string, use3D: boolean, loop: boolean, insideConeAngle: number, outsideConeAngle: number, outsideVolume: number, minDistance: number, maxDistance: number}|"{ filename = '', use3D = true, loop = true }" "Table with properties:\n- `filename` (`string`): Audio filename.\n- `use3D` (`boolean`): Set to `false` to load audio without any 3D effects.\n- `loop` (`boolean`): Set to `false` to disable audio looping.\n- `insideConeAngle` (`number`): Angle in degrees at which audio is at 100% volume.\n- `outsideConeAngle` (`number`): Angle in degrees at which audio is at `outsideVolume` volume.\n- `outsideVolume` (`number`): Volume multiplier if listener is outside of the cone.\n- `minDistance` (`number`): Distance at which audio would stop going louder as it approaches listener (default is 1).\n- `maxDistance` (`number`): Distance at which audio would attenuating as it gets further away from listener (default is 10 km)."
---@param reverbResponse boolean|`true`|`false` @Set to true if audio event should be affected by reverb in tunnels and such.
---@return ac.AudioEvent
function ac.AudioEvent.fromFile(params, reverbResponse) end

--[[ common/ac_audio.lua ]]

---Audio event is a audio emitter which uses a certain event from one of loaded FMOD soundbanks.
---@class ac.AudioEvent
---@field volume number @Audio volume, from 0 to 1 (can go above too, but clipping might occur). Default value: 1.
---@field pitch number @Audio pitch. Default value: 1.
---@field cameraInteriorMultiplier number @Multiplier for audio volume with interior camera. Default value: 0.25.
---@field cameraExteriorMultiplier number @Multiplier for audio volume with exterior (chase or free, for example) camera. Default value: 1.
---@field cameraTrackMultiplier number @Multiplier for audio volume with track camera (those replay cameras with low FOV). Default value: 1.
---@field inAutoLoopMode number @If set to `true`, aduio event would automatically start when in range of camera and volume is above 0. Default value: `false`.
local _ac_AudioEvent = nil

---Sets audio event orientation.
---@param pos vec3 @Position. If you’re working on a car script, position is relative to car position.
---@param dir vec3|nil @Direction. If missing, forwards vector is used.
---@param up vec3|nil @Vector directed up for full 3D orientation.
---@param vel vec3|nil @Velocity of audio source. If missing, sound is stationary. If you’re working on a car script, velocity is relative to car velocity.
function _ac_AudioEvent:setPosition(pos, dir, up, vel) end

---Deprecated, now all events are alive until `:dispose()` is called.
---@deprecated
function _ac_AudioEvent:keepAlive() end

---Set value of an audio event parameter.
---@param name string
---@param value number
function _ac_AudioEvent:setParam(name, value) end

---Returns `true` if event is loaded successfully. If event does not load, make sure soundbank is loaded first, and that event name is correct.
---@return boolean
function _ac_AudioEvent:isValid() end

---Returns `true` if audio event is playing.
---@return boolean
function _ac_AudioEvent:isPlaying() end

---Returns `true` if audio event is paused.
---@return boolean
function _ac_AudioEvent:isPaused() end

---Return `true` if audio event is within hearing range of current listener. Could be a good way to pause some expensive processing
---for distant audio events. Although in general comparing distance with a threshold on Lua side with vectors might be faster (without
---going Lua→CSP→FMOD and back).
---@return boolean
function _ac_AudioEvent:isWithinRange() end

function _ac_AudioEvent:resume() end

---If condition is `true`, start an audio event if it’s stopped, resume it if it’s paused. If condition is false, stop audio event.
---@param condition boolean|`true`|`false`
function _ac_AudioEvent:resumeIf(condition) end

---Stop audio event.
function _ac_AudioEvent:stop() end

---Start audio event.
function _ac_AudioEvent:start() end

---If you need to move audio event often, accessing its matrix directly might be the best way. But you have to be extra careful in
---making sure matrix is always normalized (vectors `side`, `up` and `look` should be othrogonal with lengths of 1), otherwise
---audio might sound strange, with rapid changes in volume.
---@return mat4x4
function _ac_AudioEvent:getTransformationRaw() end

---Stop and remove audio event.
function _ac_AudioEvent:dispose() end

--[[ common/ac_light.lua ]]

---Light source on the scene. Starts working immediattely after creation. Use `:dispose()` to remove it.
---@param lightType ac.LightType?
---@param position vec3?
---@return ac.LightSource
function ac.LightSource(lightType, position) end

---Light source on the scene. Starts working immediattely after creation. Use `:dispose()` to remove it.
---@class ac.LightSource
---@field lightType ac.LightType @Type of light source.
---@field position vec3 @Light position.
---@field color rgb @Light color, go above 1 to make it brighter.
---@field specularMultiplier number @Specular multiplier. Lights with it set to 0 might be a bit faster to render, especially line lights.
---@field diffuseConcentration number @Diffuse concentration. If set to 1, surfaces facing perpendicular from light source would not get lit. If lower, they’d get more and more lit, and with 0 they’d get fully lit.
---@field singleFrequency number @Increase for single-frequency effect where only surfaces with colors matching that of light source would get illuminated.
---@field range number @Range in meters.
---@field rangeGradientOffset number @Point in range at which light would start to fade, from 0 to 1. Generally lights look better with it set to 0, but if you’re trying to keep range low and light bright, sometimes it helps to be able to increase it.
---@field fadeAt number @Distance in meters at which light fades (at that distance, it would have half of its original intensity).
---@field fadeSmooth number @Distance range in which light fades. Light starts fading at `fadeAt - fadeSmooth/2` and is fully gone at `fadeAt + fadeSmooth/2`.
---@field direction vec3 @Light direction.
---@field spot number @Spot angle in degrees, if set to 0, light works like a point light. Can misbehave if set above 350° (it can be above 180°, but keep in mind, anything above 170° wouldn’t really get any dynamic shadows).
---@field spotSharpness number @Spot sharpness. At 1, edges of spotlight are fully sharp. At 0, only point that is lit to 100% is the one in the center of light spot cone.
---@field linePos vec3 @For line lights, this is a secondary position (first is `position`).
---@field lineColor rgb @For line lights, this is a secondary color (first is `color`).
---@field volumetricLight boolean @Enable volumetric light effect (requires ExtraFX to work).
---@field skipLightMap boolean @Exclude light from bounced light effect of ExtraFX (the one where light bounces from horizontal surfaces around).
---@field affectsCars boolean @If set to `false`, light would not affect cars, can speed things up slightly.
---@field showInReflections boolean @If set to `false`, light would not appear in reflection cubemap speeding things up.
---@field longSpecular number @Controls long specular effect of ExtraFX (requires SSLR), which produces extra long going outside of light range speculars on wet surfaces.
---@field shadows boolean @Use dynamic shadows.
---@field shadowsStatic boolean @Static dynamic shadows exclude any dynamic objects, so they need a much lower refresh rate.
---@field shadowsHalfResolution boolean @Half-resolution dynamic shadows for extra blurriness.
---@field shadowsExtraBlur boolean @Additional shadow blurring.
---@field shadowsSpot number @If your spotlight is too wide and you can’t reduce it, alternatively you can use a lower spot angle for shadows alone. Wouldn’t look that great though sometimes.
---@field shadowsRange number @Range of shadows, by default matches range of light source. Because those are exponential shadow maps, adjusting it might help with visual quality.
---@field shadowsBoost number @Intensity boost for exponential shadow maps.
---@field shadowsExponentialFactor number @Exponential factor for exponential shadow maps.
---@field shadowsClipPlane number @Anything closer than this value would not appear in shadow maps (works like a clipping plane perpendicular to light direction).
---@field shadowsClipSphere number @Anything closer than this value would not appear in shadow maps (works like a clipping sphere around light position).
---@field shadowsCullMode render.CullMode @Culling mode for shadows. With exponential shadow maps it’s better not to do any culling, but just in case.
---@field shadowsOffset vec3 @Offset for shadow map camera position relative to light position. Might not look that pretty, so use with caution.
local _ac_LightSource = nil

---Doesn’t do anything, kept for compatibility.
---@deprecated
function _ac_LightSource:keepAlive() end

---Removes light from the scene.
function _ac_LightSource:dispose() end

--[[ common/ac_render.lua ]]

---Draws a fullscreen pass with a custom shader. Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Example:
---```
---render.fullscreenPass({
---  async = true,
---  blendMode = render.BlendMode.BlendAdd,
---  textures = {
---    txInput1 = 'texture.png',  -- any key would work, but it’s easier to have a common prefix like “tx”
---    txInput2 = mediaPlayer,
---    txMissing = false
---  },
---  values = {
---    gValueColor = rgbm(1, 2, 0, 0.5),  -- any key would work, but it’s easier to have a common prefix like “g”
---    gValueNumber = math.random(),
---    gValueVec = vec2(1, 2),
---    gFlag = math.random() > 0.5
---  },
---  shader = [[
---    float4 main(PS_IN pin) {
---      float4 in1 = txInput1.Sample(samAnisotropic, pin.Tex);
---      float4 in2 = txInput2.Sample(samAnisotropic, pin.Tex + gValueVec);
---      return pin.ApplyFog(gFlag ? in1 + in2 * gValueColor : in2);
---    }
---  ]]
---})
---```
---
---Consider wrapping result to `pin.ApplyFog(…)` to automatically apply configured fog.
---
---Tip: to simplify and speed things up, it might make sense to move table outside of a function to reuse it from frame
---to frame, simply accessing and updating textures, values and other parameters before call. However, make sure not to
---add new textures and values, otherwise it would require to recompile shader and might lead to VRAM leaks (if you would
---end up having thousands of no more used shaders). If you don’t have a working texture at the time of first creating
---that table, use `false` for missing texture value.
---
---Note: if shader would fail to compile, a C++ exception will be triggered, terminating script completely (to prevent AC
---from crashing, C++ exceptions halt Lua script that triggered them until script gets a full reload).
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {blendMode: render.BlendMode, depthMode: render.DepthMode, depth: number, async: boolean, textures: table, values: table, shader: string}|"{\n  blendMode = render.BlendMode.AlphaBlend,\n  depthMode = render.DepthMode.ReadOnlyLessEqual,\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.AlphaBlend`.\n- `depthMode` (`render.DepthMode`): Depth mode. Default value: `render.DepthMode.ReadOnlyLessEqual`.\n- `depth` (`number`): Optional depth in meters, to use hardware-accelerated depth clipping.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function render.fullscreenPass(params) end

---Draws a 3D quad with a custom shader. Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Example:
---```
---render.shaderedQuad({
---  async = true,
---  p1 = vec3(…),
---  p2 = vec3(…),
---  p3 = vec3(…),
---  p4 = vec3(…),
---  textures = {
---    txInput1 = 'texture.png',  -- any key would work, but it’s easier to have a common prefix like “tx”
---    txInput2 = mediaPlayer,
---    txMissing = false
---  },
---  values = {
---    gValueColor = rgbm(1, 2, 0, 0.5),  -- any key would work, but it’s easier to have a common prefix like “g”
---    gValueNumber = math.random(),
---    gValueVec = vec2(1, 2),
---    gFlag = math.random() > 0.5
---  },
---  shader = [[
---    float4 main(PS_IN pin) {
---      float4 in1 = txInput1.Sample(samAnisotropic, pin.Tex);
---      float4 in2 = txInput2.Sample(samAnisotropic, pin.Tex + gValueVec);
---      return pin.ApplyFog(gFlag ? in1 + in2 * gValueColor : in2);
---    }
---  ]]
---})
---```
---
---Consider wrapping result to `pin.ApplyFog(…)` to automatically apply configured fog. To set blend mode and such, use `render.setBlendMode()`.
---
---Tip: to simplify and speed things up, it might make sense to move table outside of a function to reuse it from frame
---to frame, simply accessing and updating textures, values and other parameters before call. However, make sure not to
---add new textures and values, otherwise it would require to recompile shader and might lead to VRAM leaks (if you would
---end up having thousands of no more used shaders). If you don’t have a working texture at the time of first creating
---that table, use `false` for missing texture value.
---
---Note: if shader would fail to compile, a C++ exception will be triggered, terminating script completely (to prevent AC
---from crashing, C++ exceptions halt Lua script that triggered them until script gets a full reload).
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec3, p2: vec3, p3: vec3, p4: vec3, blendMode: render.BlendMode, async: boolean, textures: table, values: table, shader: string}|"{\n  p1 = vec3(0, 0, 0),\n  p2 = vec3(0, 1, 0),\n  p3 = vec3(1, 1, 0),\n  p4 = vec3(1, 0, 0),\n  blendMode = render.BlendMode.AlphaBlend,\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.AlphaBlend`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function render.shaderedQuad(params) end

--[[ common/ac_render_enums.lua ]]

---Render namespace for drawing custom shapes and other stuff like that.
render = {}

--[[ common/ac_ray.lua ]]

---Ray for simple geometric raycasting. Do not create ray manually, instead use `render.createRay(pos, dir, length)` or `render.createMouseRay()`.
---Do not alter direction directly, or, if you do, do not cast it against lines, triangles or meshes, it stores some other precomputed values
---for faster and more accurate raycasting.
---@class ray
---@field pos vec3 @Ray origin.
---@field dir vec3 @Ray direction.
---@field length number @Ray length (used for physics raycasting, shorter rays are faster).
local ray = nil

---Ray/AABB intersection.
---@param min vec3 @AABB min corner.
---@param max vec3 @AABB max corner.
---@return boolean @True if there was an intersection.
function ray:aabb(min, max) end

---Ray/thick line intersection.
---@param from vec3 @Line, starting point.
---@param to vec3 @Line, finishing point.
---@param width number @Line width.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:line(from, to, width) end

---Ray/plaane intersection.
---@param planePoint vec3
---@param planeNormal vec3
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:plane(planePoint, planeNormal) end

---Ray/triangle intersection.
---@param p1 vec3 @Triangle, point A.
---@param p2 vec3 @Triangle, point B.
---@param p3 vec3 @Triangle, point C.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:triangle(p1, p2, p3) end

---Ray/sphere intersection.
---@param center vec3 @Sphere, center.
---@param radius number @Sphere, radius.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:sphere(center, radius) end

---Ray/track intersection.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:track() end

---Ray/scene intersection (both with track and cars).
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:scene() end

---Ray/cars intersection.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:cars() end

---Ray/physics meshes intersection.
---@param outPosition vec3 @Optional vec3 to which contact point will be written.
---@param outNormal vec3 @Optional vec3 to which contact normal will be written.
---@return number @Intersection distance, or -1 if there was no intersection.
function ray:physics(outPosition, outNormal) end

---Distance between ray and a point.
---@param p vec3 @Point.
---@return number @Distance.
function ray:distance(p) end

--[[ common/ac_positioning_helper.lua ]]

---@return render.PositioningHelper
function render.PositioningHelper() end

---@class render.PositioningHelper
local _render_PositioningHelper = nil

---@param pos vec3
---@param forceInactive boolean? @Prevents PositioningHelper from moving. Default value: `false`.
---@return boolean
function _render_PositioningHelper:render(pos, forceInactive) end

---@param pos vec3
---@param look vec3
---@param forceInactive boolean? @Prevents PositioningHelper from moving. Default value: `false`.
---@return boolean
function _render_PositioningHelper:renderAligned(pos, look, forceInactive) end

---@param pos vec3
---@param look vec3
---@param up vec3
---@param forceInactive boolean? @Prevents PositioningHelper from moving. Default value: `false`.
---@return boolean
function _render_PositioningHelper:renderFullyAligned(pos, look, up, forceInactive) end

---@return boolean
function _render_PositioningHelper:anyHighlight() end

---@return boolean
function _render_PositioningHelper:movingInScreenSpace() end

--[[ common/ac_ui.lua ]]

---Very simple thing for smooth UI animations. Call it with a number for its initial state and it would
---return you a function. Each frame, call this function with your new target value and it would give you
---a smoothly changing numerical value. Unlike functions like `math.applyLag()`, this one is a bit more
---complicated, taking into account velocity as well.
---@param initialValue number @Initial value with which animation will start.
---@param weightMult number? @Weight multiplier for smoother or faster animation. Default value: 1.
---@return fun(target: number): number
function ui.SmoothInterpolation(initialValue, weightMult) end

---Another simple helper for easily creating elements fading in and out. Just pass it a draw callback and
---and initial state (should it be visible or not), and then call returned function every frame passing it
---a boolean to specify if item should be visible or not. Example:
---```
---local timeLeft = 120
---
---local function drawTimeLeft()
---  ui.text(string.format('Time left: %02.0f', math.max(0, timeLeft)))
---  -- keep in mind: when timer would reach 0, block would still be visible for a bit while fading out, so
---  -- that’s why there is that `math.max()` call
---end
---
---local fadingTimer = ui.FadingElement(drawTimeLeft)
---
---function script.update(dt)
---  timeLeft = timeLeft - dt
---  fadingTimer(timeLeft > 0 and timeLeft < 60)  -- only show timer if time left is below 60 seconds
---end
---```
---@param drawCallback fun() @Draw callback. Would only be called if alpha is above 0.2%, so there is no overhead if element is hidden.
---@param initialState boolean? @Should element be visible from the start. Default value: `false`.
---@return fun(state: boolean)
function ui.FadingElement(drawCallback, initialState) end

---@param name string @Name of the font, should be the name you can see when, for example, opening font with Windows Font Viewer (and not the name of the file).
---@param dir string|nil @Optionally, path to a directory with TTF files in it. If provided, instead of looking for font in “content/fonts” and “extension/fonts”, CSP will scan given folder. Alternatively you can also use a path to a file here too, if you know for sure which file it’ll be (with TTF, different styles often go in different files).
---@return ui.DWriteFont
ui.DWriteFont = function (name, dir) end

---DirectWrite font name builder. Instead of using it, you can simply provide a string, but this thing might be a nicer way. You can chain its methods too:
---```
---local MyFavouriteFont = ui.DWriteFont('Best Font', './data'):weight(ui.DWriteFont.Weight.Bold):style(ui.DWriteFont.Style.Italic):stretch(ui.DWriteFont.Stretch.Condensed)
---…
---ui.pushFont(MyFavouriteFont)  -- you could also just put font here, but if defined once and reused, it would generate less garbage for GC to clean up.
---ui.dwriteText('Hello world!', 14)
---ui.popFont()
---```
---@class ui.DWriteFont
local _uiDWriteFont = {}

---Set font weight. Bold styles can be emulated even if there isn’t such font face, although quality of real font face would be better.
---@param weight ui.DWriteFont.Weight
function _uiDWriteFont:weight(weight)
  self._weight = weight
  self._fullName = nil
  return self
end

---Set font style. Italic style can be emulated even if there isn’t such font face, although quality of real font face would be better.
---@param style ui.DWriteFont.Style
function _uiDWriteFont:style(style)
  self._style = style
  self._fullName = nil
  return self
end

---Set font stretch.
---@param stretch ui.DWriteFont.Stretch
function _uiDWriteFont:stretch(stretch)
  self._stretch = stretch
  self._fullName = nil
  return self
end

---Disable font size rounding. Please use carefully: if you would to animate font size, it would quickly generate way too many atlases
---and increase both VRAM consumption and drawing time. If you need to animate font size, consider instead using `ui.beginScale()`/`ui.endScale()`.
function _uiDWriteFont:allowRealSizes()
  self._allowRealSizes = true
  self._fullName = nil
  return self
end

--[[ common/ac_ui.lua ]]

---UI namespace for creating custom widgets or drawing dynamic textures using IMGUI.
ui = {}

---Returns an icon for a given weather type
---@param weatherType ac.WeatherType
---@return ui.Icons
function ui.weatherIcon(weatherType) end

---Push style variable.
---@param varID ui.StyleVar
---@param value number|vec2
function ui.pushStyleVar(varID, value) end

---Push ID (use it if you, for example, have a list of buttons created in a loop).
---@param value number|string
function ui.pushID(value) end

---Text input control. Returns updated string (which would be the input string unless it changed, so no)
---copying there. Second return value would change to `true` when text has changed. Example:
---```
---myText = ui.inputText('Enter something:', myText)
---```
---
---Third argument is `true` if Enter was pressed while editing text.
---@param label string
---@param str string
---@param flags ui.InputTextFlags?
---@return string
---@return boolean
---@return boolean
function ui.inputText(label, str, flags) end

---Color picker control. Returns true if color has changed (as usual with Lua, colors are passed)
---by reference so update value would be put in place of old one automatically.
---@param label string
---@param color rgb|rgbm
---@param flags ui.ColorPickerFlags?
---@return boolean
function ui.colorPicker(label, color, flags) end

---Color button control. Returns true if color has changed (as usual with Lua, colors are passed)
---by reference so update value would be put in place of old one automatically.
---@param label string
---@param color rgb|rgbm
---@param flags ui.ColorPickerFlags?
---@param size vec2?
---@return boolean
function ui.colorButton(label, color, flags, size) end

---Show popup message.
---@param icon ui.Icons
---@param message string
---@param undoCallback fun()|nil @If provided, there’ll be an undo button which, when clicked, will call this callback.
function ui.toast(icon, message, undoCallback) end

---Draw a window with transparent background.
---@generic T
---@param id string @Window ID, has to be unique within your script.
---@param pos vec2 @Window position.
---@param size vec2 @Window size.
---@param noPadding boolean? @Disables window padding. Default value: `false`.
---@param content fun(): T @Window content callback.
---@return T
---@overload fun(id: string, pos: vec2, size: vec2, content: fun())
function ui.transparentWindow(id, pos, size, noPadding, content) end

---Draw a window with semi-transparent background.
---@generic T
---@param id string @Window ID, has to be unique within your script.
---@param pos vec2 @Window position.
---@param size vec2 @Window size.
---@param noPadding boolean? @Disables window padding. Default value: `false`.
---@param content fun(): T @Window content callback.
---@return T
---@overload fun(id: string, pos: vec2, size: vec2, content: fun())
function ui.toolWindow(id, pos, size, noPadding, content) end

---Draw a tooltip with custom content.
---@generic T
---@param padding vec2? @Tooltip padding. Default value: `vec2(20, 8)`.
---@param content fun(): T @Window content callback.
---@return T
---@overload fun(content: fun())
function ui.tooltip(padding, content) end

---Draw a child window: perfect for clipping content, for scrolling lists, etc. Think of it more like
---a HTML div with overflow set to either scrolling or hidden, for example.
---@generic T
---@param id string @Window ID, has to be unique within given context (like, two sub-windows of the same window should have different IDs).
---@param size vec2 @Window size.
---@param border boolean? @Window border.
---@param flags ui.WindowFlags? @Window flags.
---@param content fun(): T @Window content callback.
---@return T
---@overload fun(id: string, size: vec2, border: boolean, content: fun())
---@overload fun(id: string, size: vec2, content: fun())
function ui.childWindow(id, size, border, flags, content) end

---Draw a tree node element: a collapsible block with content inside it (which might include other tree
---nodes). Great for grouping things together. Note: if you need to have a tree node with changing label,
---use label like “your changing label###someUniqueID” for it to work properly. Everything after “###” will
---count as ID and not be shown. Same trick applies to other controls as well, such as tabs, buttons, etc.
---@generic T
---@param label string @Tree node label (which also acts like its ID).
---@param flags ui.TreeNodeFlags? @Tree node flags.
---@param content fun(): T @Tree node content callback (called only if tree node is expanded).
---@return T
---@overload fun(label: string, content: fun())
function ui.treeNode(label, flags, content) end

---Draw a section with tabs. Inside, use `ui.tabItem()` to draw actual tabs like so:
---```
---ui.tabBar('someTabBarID', function ()
---  ui.tabItem('Tab 1', function () --[[ Contents of Tab 1 ]] end)
---  ui.tabItem('Tab 2', function () --[[ Contents of Tab 2 ]] end)
---end)
---```
---@generic T
---@param id string @Tab bar ID.
---@param flags ui.TabBarFlags? @Tab bar flags.
---@param content fun(): T @Individual tabs callback.
---@return T
---@overload fun(id: string, content: fun())
function ui.tabBar(id, flags, content) end

---Draw a new tab in a tab bar. Note: if you need to have a tab with changing label,
---use label like “your changing label###someUniqueID” for it to work properly. Everything after “###” will
---count as ID and not be shown. Same trick applies to other controls as well, such as tree nodes, buttons, etc.
---```
---ui.tabBar('someTabBarID', function ()
---  ui.tabItem('Tab 1', function () --[[ Contents of Tab 1 ]] end)
---  ui.tabItem('Tab 2', function () --[[ Contents of Tab 2 ]] end)
---end)
---```
---@generic T
---@param label string @Tab label.
---@param flags ui.TabItemFlags? @Tab flags.
---@param content fun(): T @Tab content callback (called only if tab is selected).
---@return T
---@overload fun(label: string, content: fun())
function ui.tabItem(label, flags, content) end

---Adds context menu to previously drawn item which would open when certain mouse button would be pressed. Once it happens,
---content callback will be called each frame to draw contents of said menu.
---```
---ui.itemPopup(ui.MouseButton.Right, function ()
---  if ui.selectable('Item 1') then --[[ Item 1 was clicked ]] end
---  if ui.selectable('Item 2') then --[[ Item 2 was clicked ]] end
---  ui.separator()
---  if ui.selectable('Item 3') then --[[ Item 3 was clicked ]] end
---  -- Other types of controls would also work
---end)
---```
---@generic T
---@param id string @Context menu ID.
---@param mouseButton ui.MouseButton @Mouse button
---@param content fun(): T @Menu content callback (called only if menu is opened).
---@return T
---@overload fun(id: string, content: fun())
---@overload fun(mouseButton: ui.MouseButton, content: fun())
---@overload fun(content: fun())
function ui.itemPopup(id, mouseButton, content) end

---Adds a dropdown list (aka combo box). Items are drawn in content callback function, or alternatively
---it can work with a list of strings and an ID of a selected item, returning either ID of selected item and
---boolean with `true` value if it was changed, or if ID is a refnumber, it would just return a boolean value
---for whatever it was changed or not.
---@generic T
---@param label string @Label of the element.
---@param previewValue string? @Preview value.
---@param flags ui.ComboFlags? @Combo box flags.
---@param content fun(): T @Combo box items callback.
---@return T
---@overload fun(label: string, previewValue: string?, content: fun())
---@overload fun(label: string, selectedIndex: integer, flags: ui.ComboFlags, content: string[]): integer, boolean
---@overload fun(label: string, selectedIndex: refnumber, flags: ui.ComboFlags, content: string[]): boolean
function ui.combo(label, previewValue, flags, content) end

---Adds a slider. For value, either pass `refnumber` and slider would return a single boolean with `true` value
---if it was moved (and storing updated value in passed `refnumber`), or pass a regular number and then
---slider would return number and then a boolean. Example:
---```
----- With refnumber:
---local ref = refnumber(currentValue)
---if ui.slider('Test', ref) then currentValue = ref.value end
---
----- Without refnumber:
---local value, changed = ui.slider('Test', currentValue)
---if changed then currentValue = value end
---
----- Or, of course, if you don’t need to know if it changed (and, you can always use `ui.itemEdited()` as well):
---currentValue = ui.slider('Test', currentValue)
---```
---I personally prefer to hide slider label and instead use its format string to show what’s it for. IMGUI would
---not show symbols after “##”, but use them for ID calculation.
---```
---currentValue = ui.slider('##someSliderID', currentValue, 0, 100, 'Quantity: %.0f')
---```
---By the way, a bit of clarification: “##” would do
---that, but “###” would result in ID where only symbols going after “###” are taken into account. Helps if you
---have a control which label is constantly changing. For example, a tab showing a number of elements or current time.
---
---To enter value with keyboard, hold Ctrl and click on it.
---@param label string @Slider label.
---@param value refnumber|number @Current slider value.
---@param min number? @Default value: 0.
---@param max number? @Default value: 1.
---@param format string|'%.3f'|nil @C-style format string. Default value: '%.3f'.
---@param power number? @Power for non-linear slider. Default value: 1 (linear).
---@return boolean @True if slider has moved.
---@overload fun(label: string, value: number, min: number, max: number, format: string, power: number): number, boolean
function ui.slider(label, value, min, max, format, power) end

---Draws race flag of a certain type, or in a certain color in its usual position.
---Use it if you want to add a new flag type: this way, if custom UI later would replace flags with
---a different look (or even if it’s just a custom texture mod), it would still work.
---
---Note: if your script can access physics and you need a regular flag, using `physics.overrideRacingFlag()`
---would work better (it would also affect track conditions and such).
---@param color ac.FlagType|rgbm
function ui.drawRaceFlag(color) end

---Draws icon for car state, along with low fuel icon. If more than one icon is visible at once, subsequent ones are drawn
---to the right of previous icon. Settings altering position and opacity of low fuel icon also apply here. Background is
---included by default: simply pass a semi-transparent symbol here.
---@param iconID ui.Icons|fun(iconSize: number) @Might be an icon ID or anything else `ui.icon()` can take, or a function taking icon size.
---@param color rgbm? @Icon tint for background. Default value: `rgbm.colors.white`.
function ui.drawCarIcon(iconID, color) end

---Generates ID to use with `ui.icon()` to draw an icon from an atlas.
---@param filename string @Texture filename.
---@param uv1 vec2 @UV coordinates of the upper left corner.
---@param uv2 vec2 @UV coordinates of the bottom right corner.
---@return ui.Icons @Returns an ID to be used as an argument for `ui.icon()` function.
function ui.atlasIconID(filename, uv1, uv2) end

---Generates a table acting like icons atlas.
---@generic T
---@param filename string @Texture filename.
---@param columns integer @Number of columns in the atlas.
---@param rows integer @Number of rows in the atlas.
---@param icons T @Table with icons from left top corner, each icon is a table with 1-based row and column indices.
---@return T
function ui.atlasIcons(filename, columns, rows, icons) end

---Checks if system supports these media players (Microsoft Media Foundation framework was added in Windows 8). If it’s not supported,
---you can still use API, but it would fail to load any video or audio.
---@return boolean
function ui.MediaPlayer.supported() end

---Media player which can load a video and be used as a texture in calls like `ui.drawImage()`, `ui.beginTextureShade()` or `display.image()`. Also, it can load an audio
---file and play it offscreen.
---
---Since 0.1.77, media players can also be used as textures for scene references, like `ac.findMeshes(…):setMaterialTexture()`.
---
---Uses Microsoft Media Foundation framework for video decoding and hardware acceleration, so only supports codecs supported by Windows.
---Instead of asking user to install custom codecs, it might be a better idea to use [ones available by default](https://support.microsoft.com/en-us/windows/codecs-faq-392483a0-b9ac-27c7-0f61-5a7f18d408af).
---
---Usage:
---```
---local player = ui.MediaPlayer()
---player:setSource('myVideo.wmw'):setAutoPlay(true)
---
---function script.update(dt)
---  ui.drawImage(player, vec2(), vec2(400, 200))
---end
---```
---
---When first used, MMF library is loaded and a separate DirectX device is created. Usually this process is pretty much instantaneous,
---but sometimes it might take a few seconds. During that time you can still use media player methods to set source, volume, start playback, etc.
---Some things might act a bit differently though. To make sure library is loaded before use, you can use `ui.MediaPlayer.supportedAsync()` with
---a callback.
---@param source string|nil @URL or a filename. Optional, can be set later with `player:setSource()`.
---@return ui.MediaPlayer
function ui.MediaPlayer(source) end

---Media player which can load a video and be used as a texture in calls like `ui.drawImage()`, `ui.beginTextureShade()` or `display.image()`. Also, it can load an audio
---file and play it offscreen.
---
---Since 0.1.77, media players can also be used as textures for scene references, like `ac.findMeshes(…):setMaterialTexture()`.
---
---Uses Microsoft Media Foundation framework for video decoding and hardware acceleration, so only supports codecs supported by Windows.
---Instead of asking user to install custom codecs, it might be a better idea to use [ones available by default](https://support.microsoft.com/en-us/windows/codecs-faq-392483a0-b9ac-27c7-0f61-5a7f18d408af).
---
---Usage:
---```
---local player = ui.MediaPlayer()
---player:setSource('myVideo.wmw'):setAutoPlay(true)
---
---function script.update(dt)
---  ui.drawImage(player, vec2(), vec2(400, 200))
---end
---```
---
---When first used, MMF library is loaded and a separate DirectX device is created. Usually this process is pretty much instantaneous,
---but sometimes it might take a few seconds. During that time you can still use media player methods to set source, volume, start playback, etc.
---Some things might act a bit differently though. To make sure library is loaded before use, you can use `ui.MediaPlayer.supportedAsync()` with
---a callback.
---@class ui.MediaPlayer
local _ui_MediaPlayer = nil

---Checks if system supports these media players (Microsoft Media Foundation framework was added in Windows 8). If it’s not supported,
---you can still use API, but it would fail to load any video or audio.
---
---Instead of this one, use `ui.MediaPlayer.supportedAsync()` which wouldn’t cause game to freeze while waiting for MMF to finish
---initializing.
---@deprecated
---@return boolean
function ui.MediaPlayer.supported() end

---Checks if system supports these media players (Microsoft Media Foundation framework was added in Windows 8). If it’s not supported,
---you can still use API, but it would fail to load any video or audio. Runs asyncronously.
---@param callback fun(supported: boolean)
function ui.MediaPlayer.supportedAsync(callback) end

---Sets file name or URL for video player to play. URL can lead to a remote resource.
---@param url string @URL or a filename.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setSource(url) end

---Get video resolution. Would not work right after initialization or `player:setSource()`, first video needs to finish loading.
---@return vec2 @Width and height in pixels.
function _ui_MediaPlayer:resolution() end

---Get current playback position in seconds. Can be changed with `player:setCurrentTime()`.
---@return number
function _ui_MediaPlayer:currentTime() end

---Get video duration in seconds.
---@return number
function _ui_MediaPlayer:duration() end

---Get current video volume in range between 0 and 1. Can be changed with `player:setVolume()`.
---@return number
function _ui_MediaPlayer:volume() end

---Get current video audio balance in range between -1 (left channel only) and 1 (right channel only). Can be changed with `player:setBalance()`.
---@return number
function _ui_MediaPlayer:balance() end

---Get current playback speed. Normal speed is 1. Can be changed with `player:setPlaybackRate()`.
---@return number
function _ui_MediaPlayer:playbackRate() end

---Get available time in seconds. If you are streaming a video, it might be a good idea to pause it until there would be enough of time available to play it.
---Note: sometimes might misbehave when combined with jumping to a future point in video.
---@return number
function _ui_MediaPlayer:availableTime() end

---Checks if video is playing now. Can be changed with `player:play()` and `player:pause()`.
---@return boolean
function _ui_MediaPlayer:playing() end

---Checks if video is looping. Can be changed with `player:setLooping()`.
---@return boolean
function _ui_MediaPlayer:looping() end

---Checks if video would be played automatically. Can be changed with `player:setAutoPlay()`.
---@return boolean
function _ui_MediaPlayer:autoPlay() end

---Checks if video is muted. Can be changed with `player:setMuted()`.
---@return boolean
function _ui_MediaPlayer:muted() end

---Checks if video has ended.
---@return boolean
function _ui_MediaPlayer:ended() end

---Checks if video player is seeking currently.
---@return boolean
function _ui_MediaPlayer:seeking() end

---Checks if video is ready. If MMF failed to load the video, it would return `false`.
---@return boolean
function _ui_MediaPlayer:hasVideo() end

---Checks if there is an audio to play.
---@return boolean
function _ui_MediaPlayer:hasAudio() end

---Sets video position.
---@param value number @New video position in seconds.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setCurrentTime(value) end

---Sets playback speed.
---@param value number? @New speed value from 0 to 1. Default value: 1.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setPlaybackRate(value) end

---Sets volume.
---@param value number? @New volume value from 0 to 1. Default value: 1.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setVolume(value) end

---Sets audio balance.
---@param value number? @New balance value from -1 (left channel only) to 1 (right channel only). Default value: 0.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setBalance(value) end

---Sets muted parameter.
---@param value boolean? @Set to `true` to disable audio.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setMuted(value) end

---Sets looping parameter.
---@param value boolean? @Set to `true` if video needs to start from beginning when it ends.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setLooping(value) end

---Sets auto playing parameter.
---@param value boolean? @Set to `true` if video has to be started automatically.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setAutoPlay(value) end

---Sets MIP maps generation flag. Use it if you want to tie media resource directly to a mesh instead of using it
---in UI or scriptable display.
---
---MIP maps are additional copies of the texture with half resolution, quarter resolution, etc. If in distance, GPUs
---would read those downscaled copies instead of main texture to both avoid aliasing and improve performance.
---@param value boolean? @Set to `true` to generate MIP maps.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setGenerateMips(value) end

---If you’re using a video element in UI or a scriptable display, this method would not do anything. But if you’re
---tying media to a mesh (with, for example, `ac.findMeshes():setMaterialTexture()`), this method allows to control
---how much time is passed before video is updated to the next frame. Default value: 0.05 s for 20 FPS. Set to 0
---to update video every frame (final framerate would still be limited by frame rate of original video).
---@param period number? @Update period in seconds. Default value: 0.05.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:setUpdatePeriod(period) end

---Links playback rate to simulation speed: pauses when game or replay are paused, slows down with replay slow motion,
---speeds up with replay fast forwarding.
---@param value boolean? @Set to `true` to link playback rate.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:linkToSimulationSpeed(value) end

---Sets media element to be used as texture by calling these functions:
---```
---self:setAutoPlay(true)            -- start playing once video is ready
---self:setMuted(true)               -- without audio (it wouldn’t be proper 3D audio anyway)
---self:setLooping(true)             -- start from the beginning once it ends
---self:setGenerateMips(true)        -- generate MIPs to avoid aliasing in distance
---self:linkToSimulationSpeed(true)  -- pause when game or replay are paused, etc.
---```
---Of course, you can call those functions manually, or call this one and then use any other functions
---to change the behaviour. It’s only a helping shortcut, that’s all.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:useAsTexture() end

---Starts to play a video.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:play() end

---Pauses a video. To fully stop it, use `player:pause():setCurrentTime(0)`.
---@return ui.MediaPlayer @Returns itself for chaining several methods together.
function _ui_MediaPlayer:pause() end

---Some debug information for testing and fixing things.
---@return string
function _ui_MediaPlayer:debugText() end

---@param resolution vec2|integer @Resolution in pixels. Usually textures with sizes of power of two work the best.
---@param mips integer? @Number of MIPs for a texture. MIPs are downsized versions of main texture used to avoid aliasing. Default value: 1 (no MIPs).
---@param antialiasingMode render.AntialiasingMode? @Antialiasing mode. Default value: `render.AntialiasingMode.None` (disabled).
---@param textureFormat render.TextureFormat? @Texture format. Default value: `render.TextureFormat.R8G8B8A8.UNorm`.
---@return ui.ExtraCanvas
---@overload fun(resolution: vec2|integer, mips: integer, textureFormat: render.TextureFormat)
function ui.ExtraCanvas(resolution, mips, antialiasingMode, textureFormat) end

---Extra canvases are textures you can use in UI calls instead of filenames or apply as material textures to scene geometry,
---and also edit them live by drawing things into them using “ui…” functions. A few possible use cases as an example:
---- If your app or display uses a complex background or another element, it might be benefitial to draw it into a texture once and then reuse it;
---- If you want to apply some advanced transformations to some graphics, it might work better to use texture;
---- It can also be used to blur some elements by drawing them into a texture and then drawing it blurred.
---
---Note: update happens from a different short-lived UI context, so interactive controls would not work here.
---@class ui.ExtraCanvas
local _ui_ExtraCanvas = nil

---Disposes canvas and releases resources.
function _ui_ExtraCanvas:dispose() end

---Sets canvas name for debugging. Canvases with set name appear in Lua Debug App, allowing to monitor their state.
---@param name string? @Name to display texture as. If set to `nil` or `false`, name will be reset and texture will be hidden.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:setName(name) end

---Updates texture, calling `callback` to draw things with. If you want to do several changes, it would work better to group them in a
---single `canvas:update()` call.
---
---Note: canvas won’t be cleared here, to clear it first, use `canvas:clear()` method.
---@param callback fun(dt: number) @Drawing function. Might not be called if canvas has been disposed or isn’t available for drawing into.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:update(callback) end

---Updates texture using a shadered quad. Faster than using `:update()` with `ui.renderShader()`:
---no time will be wasted setting up IMGUI pass and preparing all that data, just a single draw call.
---Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, async: boolean, textures: table, values: table, shader: string}|"{\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas. Default value: `vec2(0, 0)`.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas. Default value: size of canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.Opaque`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function _ui_ExtraCanvas:updateWithShader(params) end

---Updates texture using a shader with a fullscreen pass. Faster than using `:update()` with `ui.renderShader()`:
---no time will be wasted setting up IMGUI pass and preparing all that data, just a single draw call.
---Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Unlike `:updateWithShader()`, this version is single pass stereo-aware and can be used in the middle of
---rendering scene, and has access to camera state and some rendering pipeline textures by default (see “fullscreen.fx” template).
---Use it if you need to prepare an offscreen buffer to apply to the scene.
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, async: boolean, textures: table, values: table, shader: string}|"{\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas. Default value: `vec2(0, 0)`.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas. Default value: size of canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.Opaque`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function _ui_ExtraCanvas:updateSceneWithShader(params) end

---Clears canvas.
---@param col rgbm
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:clear(col) end

---Manually applies antialiasing to the texture (works only if it was created with a specific antialiasing mode).
---By default antialiasing is applied automatically, but calling this function switches AA to a manual mode.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:applyAntialiasing() end

---Generates MIPs. Once called, switches texture to manual MIPs generating mode. Note: this operation is not that expensive, but it’s not free.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:mipsUpdate() end

---Saves canvas as an image.
---@param filename string @Destination filename.
---@param format ac.ImageFormat|nil @Texture format (by default guessed based on texture name).
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:save(filename, format) end

---Returns image encoded in DDS format. Might be useful if you would need to store an image
---in some custom form (if so, consider compressing it with `ac.compress()`).
---
---Note: you can later use `ui.decodeImage()` to get a string which you can then pass as a texture name
---to any of texture receiving functions. This way, you can load image into a new canvas later: just
---create a new canvas (possibly using `ui.imageSize()` first to get image size) and update it drawing
---imported image to the full size of the canvas.
---@return string|nil @Binary data, or `nil` if binary data export has failed.
function _ui_ExtraCanvas:encode() end

---Returns texture resolution (or zeroes if element has been disposed).
---@return vec2
function _ui_ExtraCanvas:size() end

---Returns number of MIP maps (1 for no MIP maps and it being a regular texture).
---@return integer
function _ui_ExtraCanvas:mips() end

---Clones current canvas.
---@return ui.ExtraCanvas @Returns new canvas.
function _ui_ExtraCanvas:clone() end

---Backup current state of canvas, return a function which can be called to restore original state. Note:
---it clones current canvas texture, so don’t make too many backup copies at once.
---@return fun() @Returns function which will restore original canvas state when called. Function can be called more than once.
function _ui_ExtraCanvas:backup() end

---Copies contents from another canvas or from CPU canvas data. Faster than copying by drawing, but works only
---if size and number of MIP maps match. If not, fails quietly.
---@param other ui.ExtraCanvas|ui.ExtraCanvasData @Canvas to copy content from.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:copyFrom(other) end

---Downloads data from GPU to CPU asyncronously (usually takes about 0.15 ms to get the data). Resulting data can be
---used to access colors of individual pixels or upload it back to CPU restoring original state.
---@param callback fun(err: string, data: ui.ExtraCanvasData)
function _ui_ExtraCanvas:accessData(callback) end

---Contents of `ui.ExtraCanvas` copied to CPU. There, that data can no longer be used to draw things (but it can be uploaded
---back to GPU with `canvas:copyFrom()`), but it can be used to quickly access colors of individual pixels. Unlike `ui.ExtraCanvas`,
---instances of `ui.ExtraCanvasData` consume RAM, not VRAM.
---
---To save RAM while storing several copies of data, you can use `data:compress()` to apply fast LZ4 compression. Note that each time
---you would use data by reading colors of pixels, data would get decompressed automatically. Copying extra data back to canvas with
---`canvas:copyFrom()` works with both compressed and decompressed data (data would be decompressed temporary).
---@class ui.ExtraCanvasData
local _ui_ExtraCanvasData = nil

---Disposes canvas and releases resources.
function _ui_ExtraCanvasData:dispose() end

---Compresses data using LZ4 algorithm if data wasn’t compressed already.
---@return ui.ExtraCanvasData @Returns itself for chaining several methods together.
function _ui_ExtraCanvasData:compress() end

---Returns original texture resolution (or zeroes if data has been disposed).
---@return vec2
function _ui_ExtraCanvasData:size() end

---Returns `true` if data is currently compressed.
---@return boolean
function _ui_ExtraCanvasData:compressed() end

---Returns space taken by data in bytes.
---@return integer
function _ui_ExtraCanvasData:memoryFootprint() end

---Returns color of a pixel. If coordinates are outside, or data has been disposed, returns zeroes.
---@param x integer @0-based X coordinate.
---@param y integer @0-based Y coordinate.
---@return rgbm @Pixel color from 0 to 1.
---@overload fun(s: ui.ExtraCanvasData, pos: vec2): rgbm
function _ui_ExtraCanvasData:color(x, y) end

---Writes color of a pixel to a provided `rgbm` value. Same as `data:color()`, but does not create new color values, so should be
---easier on garbage collector and more useful if you need to go through a lot of pixels for some reason.
---@param color rgbm @0-based X coordinate.
---@param x integer @0-based X coordinate.
---@param y integer @0-based Y coordinate.
---@return rgbm @Pixel color from 0 to 1 (same as input `color`).
---@overload fun(s: ui.ExtraCanvasData, color: rgbm, pos: vec2): rgbm
function _ui_ExtraCanvasData:colorTo(color, x, y) end

---Returns a function which returns `true` when keyboard shortcut is pressed.
---@param key {key: ui.KeyIndex, ctrl: boolean, alt: boolean, shift: boolean, super: boolean}|"{ key = ui.KeyIndex.A, ctrl = false }"
---@return fun(withRepeat: boolean|nil): boolean
---@overload fun(key: ui.KeyIndex, ...): function
function ui.shortcut(key, ...) end

---Draws image using custom drawcall (not an IMGUI drawcall). Any transformations and color shifts
---wouldn’t work. But there are some extra shading features available here.
---@param params {filename: string, p1: vec2, p2: vec2, color: rgbm, colorOffset: rgbm, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, mask1: string, mask1UV1: vec2, mask1UV2: vec2, mask1Flags: render.TextureMaskFlags, mask2: string, mask2UV1: vec2, mask2UV2: vec2, mask2Flags: render.TextureMaskFlags}|"{\n  filename = '',\n  p1 = vec2(0, 0),\n  p2 = vec2(1, 1),\n  color = rgbm.colors.white,\n  uv1 = vec2(0, 0),\n  uv2 = vec2(1, 1),\n  blendMode = render.BlendMode.BlendAccurate\n}" "Table with properties:\n- `filename` (`string`): Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas.\n- `color` (`rgbm`): Tint of the image, with white it would be drawn as it is. In this call, can be above 0. Default value: `rgbm.colors.white`.\n- `colorOffset` (`rgbm`): Color offset. Default value: `rgbm.colors.transparent`.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `mask1` (`string`): Optional mask #1, resulting image will be drawn only if mask is non-transparent and with non-zero alpha channel. Default value: `nil`.\n- `mask1UV1` (`vec2`): Texture coordinates for upper left corner of a mask. Default value: `vec2(0, 0)`.\n- `mask1UV2` (`vec2`): Texture coordinates for bottom right corner of a mask. Default value: `vec2(1, 1)`.\n- `mask1Flags` (`render.TextureMaskFlags`): Flags for the first mask. Default value: 6.\n- `mask2` (`string`): Optional mask #2, resulting image will be drawn only if mask is non-transparent and with non-zero alpha channel. Default value: `nil`.\n- `mask2UV1` (`vec2`): Texture coordinates for upper left corner of a mask. Default value: `vec2(0, 0)`.\n- `mask2UV2` (`vec2`): Texture coordinates for bottom right corner of a mask. Default value: `vec2(1, 1)`.\n- `mask2Flags` (`render.TextureMaskFlags`): Flags for the second mask. Default value: 6."
function ui.renderTexture(params) end

---Draws a quad with a custom shader. Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Example:
---```
---ui.renderShader({
---  async = true,
---  p1 = vec2(),
---  p2 = ui.windowSize(),
---  blendMode = render.BlendMode.BlendAdd,
---  textures = {
---    txInput1 = 'texture.png',  -- any key would work, but it’s easier to have a common prefix like “tx”
---    txInput2 = mediaPlayer,
---    txMissing = false
---  },
---  values = {
---    gValueColor = rgbm(1, 2, 0, 0.5),  -- any key would work, but it’s easier to have a common prefix like “g”
---    gValueNumber = math.random(),
---    gValueVec = vec2(1, 2),
---    gFlag = math.random() > 0.5
---  },
---  shader = [[
---    float4 main(PS_IN pin) {
---      float4 in1 = txInput1.Sample(samAnisotropic, pin.Tex);
---      float4 in2 = txInput2.Sample(samAnisotropic, pin.Tex + gValueVec);
---      return gFlag ? in1 + in2 * gValueColor : in2;
---    }
---  ]]
---})
---```
---
---Tip: to simplify and speed things up, it might make sense to move table outside of a function to reuse it from frame
---to frame, simply accessing and updating textures, values and other parameters before call. However, make sure not to
---add new textures and values, otherwise it would require to recompile shader and might lead to VRAM leaks (if you would
---end up having thousands of no more used shaders). If you don’t have a working texture at the time of first creating
---that table, use `false` for missing texture value.
---
---Note: if shader would fail to compile, a C++ exception will be triggered, terminating script completely (to prevent AC
---from crashing, C++ exceptions halt Lua script that triggered them until script gets a full reload).
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, async: boolean, textures: table, values: table, shader: string}|"{\n  p1 = vec2(0, 0),\n  p2 = vec2(1, 1),\n  blendMode = render.BlendMode.BlendAccurate,\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function ui.renderShader(params) end

---Begins new group offset horizontally to the right, pushes item width to fill available space. Call `ui.endSubgroup()` when done.
---@param offsetX number? @Default value: 20.
function ui.beginSubgroup(offsetX) end

---Ends group began with `ui.beginSubgroup()`.
function ui.endSubgroup() end

---GIF player can be used to display animated GIFs.
---@param source string @URL, filename or binary data.
---@return ui.GIFPlayer
function ui.GIFPlayer(source) end

---GIF player can be used to display animated GIFs.
---@class ui.GIFPlayer
---@field keepRunning boolean @By default GIFs stop playing if they are not actively used in rendering. If you need them to keep running in background, set this property to `true`.
local _ui_GIFPlayer = nil

---Get GIF resolution. If GIF is not yet loaded, returns zeroes.
---@return vec2 @Width and height in pixels.
function _ui_GIFPlayer:resolution() end

---Rewinds GIF back to beginning.
---@return boolean
function _ui_GIFPlayer:rewind() end

---Checks if GIF is loaded and ready to be drawn.
---@return boolean
function _ui_GIFPlayer:ready() end

---Returns `false` if GIF decoding has failed.
---@return boolean
function _ui_GIFPlayer:valid() end

--[[ common/ac_scene.lua ]]

---Reference to one or several objects in scene. Works similar to those jQuery things which would refer to one or
---several of webpage elements. Use methods like `ac.findNodes()` to get one. Once you have a reference to some nodes,
---you can load additional KN5s, create new nodes and such in it.
---Note: it might be beneficial in general to prefer methods like `ac.findNodes()` and `ac.findMeshes()` over `ac.findAny()`.
---Should be fewer surprises this way.
---@class ac.SceneReference
local _ac_SceneReference = nil

---Dispose any resources associated with this ac.SceneReference and empty it out. Use it if you need to remove a previously
---created node or a loaded KN5.
function _ac_SceneReference:dispose() end

---Set material property. Be careful to match the type (you need the same amount of numeric values). If you’re using boolean,-
---resulting value will be either 1 or 0.
---@param property string|"'ksEmissive'"
---@param value number|vec2|vec3|rgb|vec4|rgbm|boolean
function _ac_SceneReference:setMaterialProperty(property, value) end

---Set material texture. Three possible uses:
---
---1. Pass color to create a new solid color texture:
---  ```
---  meshes:setMaterialTexture('txDiffuse', rgbm(1, 0, 0, 1)) -- for red color
---  ```
---2. Pass filename to load a new texture. Be careful, it would load texture syncronously unless it
---  was loaded before:
---  ```
---  meshes:setMaterialTexture('txDiffuse', 'filename.dds')
---  ```
---3. Pass a table with parameters to draw a texture in a style of scriptable displays. Be careful as to
---  not call it too often, make sure to limit refresh rate unless you really need a quick update. If you’re
---  working on a track script, might also be useful to check if camera is close enough with something like
---  ac.getSim().cameraPosition:closerToThan(display coordinates, some distance)
---  ```
---  meshes:setMaterialTexture('txDiffuse', {
---    textureSize = vec2(1024, 1024), -- although optional, I recommend to set it: skin could replace texture by one with different resolution
---    background = rgbm(1, 0, 0, 1),  -- set to `nil` (or remove) to reuse original texture as background, set to `false` to skip background preparation completely
---    region = {                      -- if not set, whole texture will be repainted
---        from = vec2(200, 300),
---        size = vec2(400, 400)
---    },
---    callback = function (dt)
---      display.rect{ pos = …, size = …, … }
---    end
---  })
---  ```
---@param texture string|"'txDiffuse'"|"'txNormal'"|"'txEmissive'"|"'txMaps'" @Name of a texture slot.
---@param value {callback: fun(dt: number), textureSize: vec2, region: {from: vec2, size: vec2}, background: rgbm|boolean|nil}|"{\n  callback = function (dt)  end,\n  textureSize = vec2(512, 512),\n  region = {\n    from = vec2(0, 0),\n    size = vec2(512, 512)\n  }\n}"
---@overload fun(texture: string, value: string)
---@overload fun(texture: string, value: rgbm)
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setMaterialTexture(texture, value) end

---Ensures all materials are unique, allowing to alter their textures and material properties without affecting the rest of the scene. Only
---ensures uniqueness relative to the rest of the scene. For example, if it refers to two meshes using the same material, they’ll continue
---to share material, but it would be their own material, separate from the scene.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:ensureUniqueMaterials() end

---Stores current transformation to be restored when `ac.SceneReference` is disposed (for example, when script reloads). Might be a good
---idea to use it first on any nodes you’re going to move, so all of them would get back when script is reloaded (assuming their original 
---transformation is important, like it is with needles, for example).
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:storeCurrentTransformation() end

---CSP keeps track of previous world position of each node to do its motion blur. This call would clear that value, so teleported, for
---example, objects wouldn’t have motion blur artifacts for a frame.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:clearMotion() end

---Number of elements in this reference. Alternatively, you can use `#` operator.
---@return integer
function _ac_SceneReference:size() end

---If reference is empty or not.
---@return boolean
function _ac_SceneReference:empty() end

---Find any children that match filter and return a new reference to them.
---@param filter string @Node/mesh filter.
---@return ac.SceneReference @Reference to found scene elements.
function _ac_SceneReference:findAny(filter) end

---Find any child nodes that match filter and return a new reference to them.
---@param filter string @Node filter.
---@return ac.SceneReference @Reference to found nodes.
function _ac_SceneReference:findNodes(filter) end

---Find any child meshes that match filter and return a new reference to them.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found meshes.
function _ac_SceneReference:findMeshes(filter) end

---Find any child skinned meshes that match filter and return a new reference to them.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found skinned meshes.
function _ac_SceneReference:findSkinnedMeshes(filter) end

---Find any child objects of a certain class that match filter and return a new reference to them.
---@param objectClass ac.ObjectClass @Objects class.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found skinned meshes.
function _ac_SceneReference:findByClass(objectClass, filter) end

---Filters current reference and returns new one with objects that match filter only.
---@param filter string @Node/mesh filter.
---@return ac.SceneReference @Reference to found scene elements.
function _ac_SceneReference:filterAny(filter) end

---Filters current reference and returns new one with nodes that match filter only.
---@param filter string @Node filter.
---@return ac.SceneReference @Reference to found nodes.
function _ac_SceneReference:filterNodes(filter) end

---Filters current reference and returns new one with meshes that match filter only.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found meshes.
function _ac_SceneReference:filterMeshes(filter) end

---Filters current reference and returns new one with skinned meshes that match filter only.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found skinned meshes.
function _ac_SceneReference:filterSkinnedMeshes(filter) end

---Filters current reference and returns new one with objects of a certain class that match filter only.
---@param objectClass ac.ObjectClass @Objects class.
---@param filter string @Mesh filter.
---@return ac.SceneReference @Reference to found skinned meshes.
function _ac_SceneReference:filterByClass(objectClass, filter) end

---Create a new node with a given name and attach it as a child.
---@param name string
---@param keepAlive boolean|`true`|`false` @Set to `true` to create a long-lasting node which wouldn’t be removed when script is reloaded.
---@return ac.SceneReference @Newly created node or nil if failed
function _ac_SceneReference:createNode(name, keepAlive) end

---Create a new bounding sphere node with a given name and attach it as a child. Using those might help with performance: children
---would skip bounding frustum test, and whole node would not get traversed during rendering if it’s not in frustum.
---
---Note: for it to work properly, it’s better to attach it to AC cars node, as that one does expect those bounding sphere nodes
---to be inside of it. You can find it with `ac.findNodes('carsRoot:yes')`.
---@param name string
---@return ac.SceneReference @Can return nil if failed.
function _ac_SceneReference:createBoundingSphereNode(name, radius) end

---Load KN5 model and attach it as a child. To use remote models, first load them with `web.loadRemoteModel()`.
---
---Node: The way it actually works, KN5 would be loaded in a pool and then copied here (with sharing
---of resources such as vertex buffers). This generally helps with performance.
---@param filename string @KN5 filename relative to script folder or AC root folder.
---@return ac.SceneReference @Can return nil if failed.
function _ac_SceneReference:loadKN5(filename) end

---Load KN5 LOD model and attach it as a child. Parameter `mainFilename` should refer to the main KN5 with all the textures.
---
---Node: The way it actually works, KN5 would be loaded in a pool and then copied here (with sharing
---of resources such as vertex buffers). This generally helps with performance. Main KN5 would be
---loaded as well, but not shown, and instead kept in a pool.
---@param filename string @KN5 filename relative to script folder or AC root folder.
---@param mainFilename string @Main KN5 filename relative to script folder or AC root folder.
---@return ac.SceneReference @Can return nil if failed.
function _ac_SceneReference:loadKN5LOD(filename, mainFilename) end

---Load KN5 model and attach it as a child asyncronously. To use remote models, first load them with `web.loadRemoteModel()`.
---
---Node: The way it actually works, KN5 would be loaded in a pool and then copied here (with sharing
---of resources such as vertex buffers). This generally helps with performance.
---@param filename string @KN5 filename relative to script folder or AC root folder.
---@param callback fun(err: string, loaded: ac.SceneReference?) @Callback called once model is loaded.
function _ac_SceneReference:loadKN5Async(filename, callback) end

---Load KN5 model and attach it as a child asyncronously. Parameter `mainFilename` should refer to the main KN5 with all the textures.
---
---Node: The way it actually works, KN5 would be loaded in a pool and then copied here (with sharing
---of resources such as vertex buffers). This generally helps with performance. Main KN5 would be
---loaded as well, but not shown, and instead kept in a pool.
---@param filename string @KN5 filename relative to script folder or AC root folder.
---@param mainFilename string @Main KN5 filename relative to script folder or AC root folder.
---@param callback fun(err: string, loaded: ac.SceneReference?) @Callback called once model is loaded.
function _ac_SceneReference:loadKN5LODAsync(filename, mainFilename, callback) end

---Loads animation from a file (on first call only), sets animation position. To use remote animations, first load them with `web.loadRemoteAnimation()`.
---@param filename string @Animation filename (”…ksanim”). If set to `nil`, no animation will be applied.
---@param position number? @Animation position from 0 to 1. Default value: 0.
---@param force boolean? @If not set to `true`, animation will be applied only if position is different from position used previously. Default value: `false`.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setAnimation(filename, position, force) end

---@param visible boolean|`true`|`false`
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setVisible(visible) end

---@param shadows boolean|`true`|`false`
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setShadows(shadows) end

---@param transparent boolean|`true`|`false`
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setTransparent(transparent) end

---Sets attribute associated with current meshes or nodes. Attributes are stored as strings, but you can access them as numbers with `:getAttibute()` by
---passing number as `defaultValue`. To find meshes with a certain attribute, use “hasAttribute:name” search query.
---@param key string
---@param value number|string|nil @Pass `nil` to remove an attribute.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setAttribute(key, value) end

---Gets an attribute value.
---@param key string
---@param defaultValue number|string|nil @If `nil` is passed, returns string (or `nil` if attribute is not set).
---@return string|number|nil @Type is determined based on type of `defaultValue`.
function _ac_SceneReference:getAttribute(key, defaultValue) end

---Reference:
---- Reduced TAA: 1;
---- Extra TAA: 0.5.
---@param value number
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setMotionStencil(value) end

---Sets position of a node (or nodes).
---
---Note: only nodes can move. If you need to move meshes, find their parent node and move it. If its parent node has more than a single mesh as a child,
---create a new node as a child of that parent and move mesh there.
---@param pos vec3
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setPosition(pos) end

---Sets orientation of a node (or nodes). If vector `up` is not provided, facing up vector will be used.
---
---Note: only nodes can rotate. If you need to rotate meshes, find their parent node and rotate it. If its parent node has more than a single mesh as a child,
---create a new node as a child of that parent and move mesh there.
---@param look vec3
---@param up vec3|nil
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setOrientation(look, up) end

---Replaces orientation of a node (or nodes) with rotational matrix. If you want to just rotate node from its current orientation, use `:rotate()`.
---
---Note: only nodes can rotate. If you need to rotate meshes, find their parent node and rotate it. If its parent node has more than a single mesh as a child,
---create a new node as a child of that parent and move mesh there.
---@param axis vec3
---@param angleRad number
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setRotation(axis, angleRad) end

---Rotates node (or nodes) relative to its current orientation. If you want to completely replace its orientation by rotating matrix, use `:setRotation()`.
---
---Note: only nodes can rotate. If you need to rotate meshes, find their parent node and rotate it. If its parent node has more than a single mesh as a child,
---create a new node as a child of that parent and move mesh there.
---@param axis vec3
---@param angleRad number
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:rotate(axis, angleRad) end

---Returns position of a first node relative to its parent.
---@return vec3
function _ac_SceneReference:getPosition() end

---Returns direction a first node is looking towards relative to its parent.
---@return vec3
function _ac_SceneReference:getLook() end

---Returns direction upwards of a first node relative to its parent.
---@return vec3
function _ac_SceneReference:getUp() end

---Returns number of children of all nodes in current scene reference.
---@return integer
function _ac_SceneReference:getChildrenCount() end

---Returns reference to transformation matrix of the first node relative to its parent. If you need to move
---something often, accessing its matrix directly might be the best way. Be careful though, if there
---are no nodes in the list, it would return `nil`.
---@return mat4x4 @Reference to transformation matrix of the first node, or nil. Use `mat4x4:set()` to update its value, or access its rows directly.
function _ac_SceneReference:getTransformationRaw() end

---Returns world transformation matrix of the first node. Do not use it to move node in world space (if you need
---to move in world space, either use `ref:getTransformationRaw():set(worldSpaceTransform:mul(ref:getParent():getWorldTransformationRaw():inverse()))` or
---simply move your node to a node without transformation, like root of dynamic objects). Be careful though, if there
---are no nodes in the list, it would return `nil`.
---@return mat4x4 @Reference to transformation matrix of the first node, or nil. Use `mat4x4:set()` to update its value, or access its rows directly.
function _ac_SceneReference:getWorldTransformationRaw() end

---Sets object transformation to match transformation of a `physics.RigidBody` instance. If this object is within another object with non-identity transformation,
---it will be taken into account.
---
---There is also a method `physics.RigidBody:setTransformationFrom()` doing the opposite (and requiring an inverse of this matrix).
---@param rigidBody physics.RigidBody @Physics entity to sync transformation with.
---@param localTransform mat4x4? @Optional transformation of scene reference nodes relative to the physics entity.
---@return physics.RigidBody @Returns self for easy chaining.
function _ac_SceneReference:setTransformationFrom(rigidBody, localTransform) end

---Returns AABB (minimum and maximum coordinates in vector) of static meshes in current selection. Only regular static meshes
---are taken into account (meshes created when KN5 is exported in track mode).
---@return vec3 @Minimum coordinate.
---@return vec3 @Maximum coordinate.
---@return integer @Number of static meshes in selection.
function _ac_SceneReference:getStaticAABB() end

---Returns AABB (minimum and maximum coordinates in vector) of meshes in current selection in local mesh coordinates. Recalculates
---AABB live, might take some time with high-poly meshes.
---@return vec3 @Minimum coordinate.
---@return vec3 @Maximum coordinate.
---@return integer @Number of static meshes in selection.
function _ac_SceneReference:getLocalAABB() end

---Returns a new scene reference with a child in certain index (assuming current scene reference points to node). If current reference
---contains several nodes, children from all of them at given index will be collected.
---@param index integer? @1-based index of a child. Default value: 1.
---@return ac.SceneReference
function _ac_SceneReference:getChild(index) end

---Returns a new scene reference with first-class children (not children of children) of all nodes in current reference.
---@param index integer? @1-based index of a child. Default value: 1.
---@return ac.SceneReference
function _ac_SceneReference:getChildren() end

---Returns a new scene reference with a parent of an object in current scene reference. If current reference
---contains several objects, parents of all of them will be collected.
---@return ac.SceneReference
function _ac_SceneReference:getParent() end

---Adds nodes and meshes from another scene reference to current scene reference.
---@param sceneRef ac.SceneReference @Scene reference to append.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:append(sceneRef) end

---Casts a ray prepared by something like `render.createRay(pos, dir, length)` or `render.createMouseRay()`.
---
---If you need to access a mesh that was hit, set second argument to true:
---```
---local hitDistance, hitMesh = mesh:raycast(render.createRay(pos, dir), true)
---if hitDistance ~= -1 then
---  print(hitMesh:name())
---end
---```
---Alternatively, reuse your own scene reference for better performance if you need to cast
---a lot of rays:
---```
---local hitMesh = ac.emptySceneReference()
---local hitDistance = mesh:raycast(render.createRay(pos, dir), hitMesh)
---if hitDistance ~= -1 then
---  print(hitMesh:name())
---end
---```
---@param ray ray
---@param outSceneRef ac.SceneReference|boolean|nil
---@param outPosRef vec3|nil @Local position (not the world one).
---@param outNormalRef vec3|nil @Local normal.
---@param outUVRef vec2|nil @Texture coordinate.
---@return number @Distance to hit, or -1 if there was no hit.
---@return ac.SceneReference|nil @Reference to a mesh that was hit (same as `outSceneRef`, doubled here for convenience).
function _ac_SceneReference:raycast(ray, outSceneRef, outPosRef, outNormalRef, outUVRef) end

---Get name of an element.
---@param index integer|nil @1-based index of an element to get a name of. Default value: 1.
---@return string @Node or mesh name.
function _ac_SceneReference:name(index) end

---Get class of an element.
---@param index integer|nil @1-based index of an element to get a class of. Default value: 1.
---@return ac.ObjectClass @Number for class of an object.
function _ac_SceneReference:class(index) end

---Get material name of an element.
---@param index integer|nil @1-based index of an element to get a material name of. Default value: 1.
---@return string @Material name.
function _ac_SceneReference:materialName(index) end

---Get shader name of an element.
---@param index integer|nil @1-based index of an element to get a shader name of. Default value: 1.
---@return string @Shader name.
function _ac_SceneReference:shaderName(index) end

---Get number of texture slots of an element.
---@param index integer|nil @1-based index of an element to get number of texture slots of. Default value: 1.
---@return integer @Number of texture slots.
function _ac_SceneReference:getTextureSlotsCount(index) end

---Get number of material properties of an element.
---@param index integer|nil @1-based index of an element to get number of material properties of. Default value: 1.
---@return integer @Number of material properties.
function _ac_SceneReference:getMaterialPropertiesCount(index) end

---Get name of a certain texture slot of an element.
---@param index integer|nil @1-based index of an element to get a name of a certain texture slot of. Default value: 1.
---@param slotIndex integer|nil @1-based index of a texture slot. Default value: 1.
---@return string|nil @Texture slot name (like “txDiffuse” or “txNormal”) or `nil` if there is no such element or property.
function _ac_SceneReference:getTextureSlotName(index, slotIndex) end

---Get name of a certain material property of an element.
---@param index integer|nil @1-based index of an element to get a name of a certain material property of. Default value: 1.
---@param slotIndex integer|nil @1-based index of a material property. Default value: 1.
---@return string|nil @Material property name (like “ksDiffuse” or “ksAmbient”) or `nil` if there is no such element or property.
function _ac_SceneReference:getMaterialPropertyName(index, slotIndex) end

---Get index of a certain texture slot of an element from the name of that slot.
---@param index integer|nil @1-based index of an element to get an index of a texture slot of. Default value: 1.
---@param slotName string|"'txDiffuse'"|"'txNormal'"|"'txEmissive'"|"'txMaps'" @Name of a texture slot.
---@return integer|nil @1-based texture slot index, or `nil` if there is no such property.
---@overload fun(s: ac.SceneReference, slotName: string): integer|nil
function _ac_SceneReference:getTextureSlotIndex(index, slotName) end

---Get index of a certain material property of an element from the name of that property.
---@param index integer|nil @1-based index of an element to get an index of a material property of. Default value: 1.
---@param propertyName string|"'ksDiffuse'"|"'ksAmbient'"|"'ksEmissive'" @Name of material property.
---@return integer|nil @1-based material property index, or `nil` if there is no such property.
---@overload fun(s: ac.SceneReference, propertyName: string): integer|nil
function _ac_SceneReference:getMaterialPropertyIndex(index, propertyName) end

---Get texture filename of a certain texture slot of an element.
---@param index integer|nil @1-based index of an element to get a texture filename of. Default value: 1.
---@param slot string|integer|nil|"'txDiffuse'"|"'txNormal'"|"'txEmissive'"|"'txMaps'" @Texture slot name or a 1-based index of a texture slot. Default value: 1.
---@return string|nil @Texture filename or `nil` if there is no such slot or element.
---@overload fun(s: ac.SceneReference, slot: string): string
function _ac_SceneReference:getTextureSlotFilename(index, slot) end

---Get value of a certain material property of an element.
---@param index integer|nil @1-based index of an element to get a material property of. Default value: 1.
---@param property string|integer|nil|"'ksDiffuse'"|"'ksAmbient'"|"'ksEmissive'" @Material property name or a 1-based index of a material property. Default value: 1.
---@return number|vec2|vec3|vec4|nil @Material property value (type depends on material property type), or `nil` if there is no such element or material property.
---@overload fun(s: ac.SceneReference, property: string): number|vec2|vec3|vec4|nil
function _ac_SceneReference:getMaterialPropertyValue(index, property) end

---Get number of materials in given scene reference (not recursive, only checks meshes and skinned meshes). If same material is used
---for two different meshes, it would only count once. Materials sharing same name can be different (for example, applying “[SHADER_REPLACEMENT_...]”
---via config to some meshes, not materials, forks their materials to not affect other meshes using the same material).
---@return integer @Number of materials.
function _ac_SceneReference:getMaterialsCount() end

---Get bounding sphere of an element. Works only with meshes or skinned meshes, nodes will return nil.
---@param index integer|nil @1-based index of an element to get a bounding sphere of. Default value: 1.
---@param outVec vec3|nil @Optional vector to use for bounding sphere position, to avoid creating new vector.
---@return vec3|nil @Center of bounding sphere in parent node coordinates, or nil if there is no bounding sphere (if it’s not a mesh or a skinned mesh).
---@return number|nil @Radius of bounding sphere, or nil if there is no bounding sphere (if it’s not a mesh or a skinned mesh).
function _ac_SceneReference:boundingSphere(index, outVec) end

---Applies skin to nodes or meshes (if ran with nodes, will apply skin to all of their children meshes).
---Skin is a table storing texture names and filenames to skin textures. Example:
---```
---local skinDir = ac.getFolder(ac.FolderID.ContentCars) .. '/' .. ac.getCarID(0) .. '/skins/my_skin'
---ac.findNodes('carRoot:0'):applySkin({
---  ['metal_details.dds'] = skinDir .. '/metal_details.dds'
---})
---```
---@param skin table<string, string>
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:applySkin(skin) end

---Resets textures to ones from associated KN5 file where possible.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:resetSkin() end

---Change parent of nodes in current reference.
---@param parentSceneRef ac.SceneReference|nil @Set to nil to disconnect node from a scene.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setParent(parentSceneRef) end

---Finds materials in another scene reference that have the same names as materials in a given scene reference,
---and copies them over, so after that both references would share materials. Example use case: if you have LOD A and
---LOD B and LOD A got unique materials (because there are multiple objects sharing same KN5 model), with this function
---it’s possible to sync together materials from LOD A and LOD B by running `lodB:setMaterialsFrom(lodA)`. And because
---materials would not be actually copied, but instead shared, any consequent change of material properly in LOD A would
---be mirrored in LOD B.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setMaterialsFrom(materialSceneRef) end

---Creates a new scene reference with just a single item from the original scene reference.
---Indices are 1-based. By default it would create a new scene reference, if you need to access
---a lot of objects fast, provide your own:
---```
---  local meshes = ac.findMeshes('shader:ksTree')
---  local ref = ac.emptySceneReference()
---  for i = 1, #meshes do
---    meshes:at(i, ref)
---    print(ref:name())  -- note: for this particular case, it would be more optimal to use meshes:name(i) instead
---  end
---```
---@param index integer @1-based index.
---@param outSceneRef ac.SceneReference|nil
---@return ac.SceneReference @Reference to a child, might be empty if there is no such child.
function _ac_SceneReference:at(index, outSceneRef) end

---Returns number of nodes and meshes matching between this and another scene reference. Could be used to quickly find out if a certain element is in a set.
---@param s ac.SceneReference
---@param other nil|ac.SceneReference|ac.SceneReference[] @Can be a single scene reference or a table with several of them. 
---@return integer
function _ac_SceneReference:countMatches(other) end

---Creates a new scene reference containing unique elements from both sets.
---@param s ac.SceneReference
---@param other nil|ac.SceneReference|ac.SceneReference[] @Can be a single scene reference or a table with several of them.
---@return ac.SceneReference
function _ac_SceneReference:makeUnionWith(other) end

---Creates a new scene reference containing only the elements found in both of original sets.
---@param s ac.SceneReference
---@param other nil|ac.SceneReference|ac.SceneReference[] @Can be a single scene reference or a table with several of them. 
---@return ac.SceneReference
function _ac_SceneReference:makeIntersectionWith(other) end

---Creates a new scene reference containing only the elements found in first set, but not in second set.
---@param s ac.SceneReference
---@param other nil|ac.SceneReference|ac.SceneReference[] @Can be a single scene reference or a table with several of them. 
---@return ac.SceneReference
function _ac_SceneReference:makeSubtractionWith(other) end

---Create new fake shadow node. Uses the same shading as track fake shadows.
---@param params {points: vec3[], opacity: number, squaredness: vec2}|"{ points = {  }, opacity = 1, squaredness = vec2() }" "@Params for newly created node."
---@return ac.SceneReference @Reference to a newly created object.
function _ac_SceneReference:createFakeShadow(params) end

---Sets fake shadow points if current reference was created with `sceneReference:createFakeShadow()`.
---@param points vec3[] @Four corners.
---@param corners number[] @Four numbers for corner intensity.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setFakeShadowPoints(points, corners) end

---Sets fake shadow squaredness if current reference was created with `sceneReference:createFakeShadow()`.
---@param squaredness vec2 @X is squaredness along one axis, Y is along another.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setFakeShadowSquaredness(squaredness) end

---Sets fake shadow opacity if current reference was created with `sceneReference:createFakeShadow()`.
---@param opacity number @Value from 0 to 1.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:setFakeShadowOpacity(opacity) end

---Applies shader replacements stored in INI config format. Can optionally load included files, so templates
---work as well. If there is no symbol “[” in `data`, applies passed values to all meshes and materials in selection.
---@param data string @Config in INIPP format.
---@param includeType ac.IncludeType? @Include type. If not set, includes will not be resolved, so templates won’t work. Default value: `ac.IncludeType.None`.
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:applyShaderReplacements(data, includeType) end

---Projects texture onto a mesh or few meshes, draws result. Use in when updating a dynamic texture, display or an extra canvas.
---Position, and directions are set in world space.
---
---Note: this is not a regular IMGUI drawing call, so most functions, such as shading offsets, transformations or clipping, would 
---not work here.
---
---Tip 1: if you want to draw a new skin for a car and apply AO to it, one way might be to draw it in a canvas and then draw
---original AO texture on top with special shading parameters:
---```
----- drawing rest of skin here
---ui.setShadingOffset(0, 0, 0, -1)
---ui.drawImage('car::EXT_body.dds', 0, ui.windowSize(), rgbm.colors.black)  -- with these shading offset properties, texture
---    -- will be drawn in black with inverse of brightness used for opacity
---ui.resetShadingOffset()
---```
---
---Tip 2: if you want to project things on meshes with certain material, make sure to filter out meshes so that it would only
---affect meshes from LOD A (instead of `ac.findMeshes('material:car_paint')` use `ac.findMeshes('{ material:car_paint & lod:A}')`),
---otherwise there’d be quite a few artifacts. I spent some time like this trying to figure out why results were off.
---@param params {filename: string, pos: vec3, look: vec3, up: vec3, color: rgbm, colorOffset: rgbm, size: vec2, depth: number, skew: vec2, tiling: vec2, doubleSided: boolean, uvOffset: vec2, blendMode: render.BlendMode, mask1: string, mask1UV1: vec2, mask1UV2: vec2, mask1Flags: render.TextureMaskFlags, mask2: string, mask2UV1: vec2, mask2UV2: vec2, mask2Flags: render.TextureMaskFlags}|"{\n  filename = '',\n  pos = vec3(),\n  look = vec3(),\n  up = vec3(0, 1, 0),\n  color = rgbm.colors.white,\n  size = vec2(),\n  depth = 1e9,\n  doubleSided = false\n}" "Table with properties:\n- `filename` (`string`): Path to a texture, or a texture element (`ui.MediaElement`, `ui.ExtraCanvas`, `ac.GeometryShot`).\n- `pos` (`vec3`): Position from which texture will be projected, in world space.\n- `look` (`vec3`): Direction with which texture will be projected, in world space.\n- `up` (`vec3`): Optional vector directed up, to specify texture rotation.\n- `color` (`rgbm`): Optional color. Default value: `rgbm.colors.white`.\n- `colorOffset` (`rgbm`): Optional color offset. Default value: `rgbm.colors.transparent`.\n- `size` (`vec2`): Size, horizontal and vertical. Default value: `vec2(1, 1)`.\n- `depth` (`number`): Depth: how far from camera projection goes, with a smooth falloff. Default value: 1e9.\n- `skew` (`vec2`): Optional skew. Default value: `vec2(0, 0)`.\n- `tiling` (`vec2`): Optional tiling for horizontal and vertical axis. With 1 tiles normally, with -1 tiles with flipping, other values are currently reserved. Default value: `vec2(0, 0)` (no tiling).\n- `doubleSided` (`boolean`): Set to `true` to draw things on surfaces facing away as well. Default value: `false`.\n- `uvOffset` (`vec2`): Optional UV offset. By default CSP estimates an UV offset such that most triagles would be shown. If mapping is way off though, it might need tweaking (or even repeated calls with different offsets).\n- `blendMode` (`render.BlendMode`): Optional override for blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `mask1` (`string`): Optional masking texture.\n- `mask1UV1` (`vec2`): Optional masking texture UV coordinates.\n- `mask1UV2` (`vec2`): Optional masking texture UV coordinates.\n- `mask1Flags` (`render.TextureMaskFlags`): Optional masking texture flags.\n- `mask2` (`string`): Optional secondary masking texture.\n- `mask2UV1` (`vec2`): Optional secondary masking texture UV coordinates.\n- `mask2UV2` (`vec2`): Optional secondary masking texture UV coordinates.\n- `mask2Flags` (`render.TextureMaskFlags`): Optional secondary masking texture flags."
---@return ac.SceneReference @Returns self for easy chaining.
function _ac_SceneReference:projectTexture(params) end

---Projects shader onto a mesh or few meshes, draws result. Use in when updating a dynamic texture, display or an extra canvas.
---Position, and directions are set in world space. Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.      
---
---Example:
---```
---local ray = render.createMouseRay()
---meshes:projectShader({
---  async = true,
---  pos = ray.pos,
---  look = ray.dir,
---  blendMode = render.BlendMode.Opaque,
---  textures = {
---    txInput1 = 'texture.png',  -- any key would work, but it’s easier to have a common prefix like “tx”
---    txInput2 = mediaPlayer,
---    txMissing = false
---  },
---  values = {
---    gValueColor = rgbm(1, 2, 0, 0.5),  -- any key would work, but it’s easier to have a common prefix like “g”
---    gValueNumber = math.random(),
---    gValueVec = vec2(1, 2),
---    gFlag = math.random() > 0.5
---  },
---  shader = [[
---    float4 main(PS_IN pin) { 
---      if (dot(abs(pin.Tex * 2 - 1), 1) > 0.5) return 0;
---      float4 in1 = txInput1.Sample(samAnisotropic, pin.Tex);
---      float4 in2 = txInput2.Sample(samAnisotropic, pin.Tex + gValueVec);
---      return gFlag ? pin.NormalView * in1 + in2 * gValueColor : in2;
---    }
---  ]]
---})
---```
---
---Tip: to simplify and speed things up, it might make sense to move table outside of a function to reuse it from frame
---to frame, simply accessing and updating textures, values and other parameters before call. However, make sure not to
---add new textures and values, otherwise it would require to recompile shader and might lead to VRAM leaks (if you would
---end up having thousands of no more used shaders). If you don’t have a working texture at the time of first creating
---that table, use `false` for missing texture value.
---
---Note: if shader would fail to compile, a C++ exception will be triggered, terminating script completely (to prevent AC 
---from crashing, C++ exceptions halt Lua script that triggered them until script gets a full reload).
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {pos: vec3, look: vec3, up: vec3, size: vec2, withDepth: boolean, expanded: boolean, uvOffset: vec2, blendMode: render.BlendMode, async: boolean, textures: table, values: table, shader: string}|"{\n  pos = vec3(),\n  look = vec3(),\n  up = vec3(0, 1, 0),\n  size = vec2(),\n  withDepth = true,\n  expanded = true,\n  blendMode = render.BlendMode.BlendAccurate,\n  textures = {\n    \n  },\n  values = {\n    \n  },\n  shader = [[float4 main(PS_IN pin) {\n    return float4(pin.Tex.x, pin.Tex.y, 0, 1);\n  }]]\n}" "Table with properties:\n- `pos` (`vec3`): Position from which texture will be projected, in world space.\n- `look` (`vec3`): Direction with which texture will be projected, in world space.\n- `up` (`vec3`): Optional vector directed up, to specify texture rotation.\n- `size` (`vec2`): Size, horizontal and vertical. Default value: `vec2(1, 1)`.\n- `withDepth` (`boolean`): If depth is used, nearest to projection position triagles will have higher priority (in case of overlapping UV), slightly slower, but produces better results (especially with `expanded` set to `true`).\n- `expanded` (`boolean`): Draws each mesh four additional times with small offsets to fill partically covered pixels. More expensive (but less expensive comparing to fixing issue with those half covered pixels with additional draw calls via Lua).\n- `uvOffset` (`vec2`): Optional UV offset. By default CSP estimates an UV offset such that most triagles would be shown. If mapping is way off though, it might need tweaking (or even repeated calls with different offsets).\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/project.fx” (look into it to see what fields are available)."
function _ac_SceneReference:projectShader(params) end

---@return ac.SceneReference
function ac.emptySceneReference() end

---Creates a new scene reference containing objects (nodes, meshes, etc.) collected with a filter from root node associated with current script. For most scripts it would be an AC root node. For track scripts,
---track root node. For car scripts, car’s root.
---
---Node: for most cases, using `ac.findNodes()`, `ac.findMeshes()` and similar would work better.
---@param s string @Node/mesh filter.
---@return ac.SceneReference
function ac.findAny(s) end

---Creates a new scene reference containing nodes collected with a filter from root node associated with current script. For most scripts it would be an AC root node. For track scripts,
---track root node. For car scripts, car’s root.
---
---Just a reminder, nodes refer to parent objects. Themselves, don’t get rendered, only their children elements (which might be nodes or meshes), but they can move.
---
---Filter is regular stuff, the same as used in INI configs. To use complex filter with commas and operators, wrap it in curly brackets as usual. There are also some special keywords available:
---- `'luaRoot:yes'`: root node associated with current script.
---- `'sceneRoot:yes'`: the most root node.
---- `'carsRoot:yes'`: node that hosts all the cars. If you want to load custom dynamic objects, especially complex, it’s recommended to load them in bounding sphere and attach here (this node is optimized to render bounding sphere-wrapped objects quickly).
---- `'trackRoot:yes'`: track root node.
---- `'staticRoot:yes'`: node with static geometry (affected by motion blur from original AC).
---- `'dynamicRoot:yes'`: node with dynamic geometry (node affected by motion blur from original AC).
---
---Note: if you’re adding new objects to a car, seach for `'BODYTR'` node. Car root remains stationary and hosts “BODYTR” for main car model and things like wheels and suspension nodes.
---@param s string @Node filter.
---@return ac.SceneReference
function ac.findNodes(s) end

---Creates a new scene reference containing meshes collected with a filter from root node associated with current script. For most scripts it would be an AC root node. For track scripts,
---track root node. For car scripts, car’s root.
---
---Just as a reminder, meshes can’t move. If you want to move a mesh, find its parent node and move it. If parent node has more than a single mesh, you can create a new parent node and move
---mesh found with `ac.findMeshes()` there.
---
---Filter is regular stuff, the same as used in INI configs. To use complex filter with commas and operators, wrap it in curly brackets as usual.
---@param s string @Mesh filter.
---@return ac.SceneReference
function ac.findMeshes(s) end

---Creates a new scene reference containing skinned meshes collected with a filter from root node associated with current script. For most scripts it would be an AC root node. For track scripts,
---track root node. For car scripts, car’s root.
---
---Filter is regular stuff, the same as used in INI configs. To use complex filter with commas and operators, wrap it in curly brackets as usual.
---@param s string @Mesh filter.
---@return ac.SceneReference
function ac.findSkinnedMeshes(s) end

---Creates a new scene reference containing objects of a certain class collected with a filter from root node associated with current script. For most scripts it would be an AC root node. For track scripts,
---track root node. For car scripts, car’s root.
---
---Filter is regular stuff, the same as used in INI configs. To use complex filter with commas and operators, wrap it in curly brackets as usual.
---@param objectClass ac.ObjectClass @Objects class.
---@param s string @Mesh filter.
---@return ac.SceneReference
function ac.findByClass(objectClass, s) end

---This thing allows to draw 3D objects in UI functions (or use them as textures in `ac.SceneReference:setMaterialTexture()`, 
---for example). Prepare a scene reference (might be a bunch of nodes or meshes), create a new `ac.GeometryShot` with that reference,
---call `ac.GeometryShot:update()` with camera parameters and then use resulting shot instead of a texture name.
---
---Each `ac.GeometryShot` holds a GPU texture in R8G8B8A8 format with optional MIPs and additional depth texture in D32 format, so
---don’t create too many of those and use `ac.GeometryShot:dispose()` for shots you no longer need (or just lose them to get garbage
---collected, but it might take more time.
---
---
---@param sceneReference ac.SceneReference @Reference to nodes or meshes to draw.
---@param resolution vec2 @Resolution in pixels. Usually textures with sizes of power of two work the best.
---@param mips integer? @Number of MIPs for a texture. MIPs are downsized versions of main texture used to avoid aliasing. Default value: 1 (no MIPs).
---@param withDepth boolean? @If set to `true`, depth buffer will be available to show as well.
---@param antialiasingMode render.AntialiasingMode? @Antialiasing mode. Default value: `render.AntialiasingMode.None` (disabled).
---@return ac.GeometryShot
function ac.GeometryShot(sceneReference, resolution, mips, withDepth, antialiasingMode) end

---This thing allows to draw 3D objects in UI functions (or use them as textures in `ac.SceneReference:setMaterialTexture()`, 
---for example). Prepare a scene reference (might be a bunch of nodes or meshes), create a new `ac.GeometryShot` with that reference,
---call `ac.GeometryShot:update()` with camera parameters and then use resulting shot instead of a texture name.
---
---Each `ac.GeometryShot` holds a GPU texture in R8G8B8A8 format with optional MIPs and additional depth texture in D32 format, so
---don’t create too many of those and use `ac.GeometryShot:dispose()` for shots you no longer need (or just lose them to get garbage
---collected, but it might take more time.
---
---
---@class ac.GeometryShot
local _ac_GeometryShot = nil

---Disposes geometry shot and releases resources.
function _ac_GeometryShot:dispose() end

---Updates texture making a shot of referenced geometry with given camera parameters. Camera coordinates are set in world space.
---
---To make orthogonal shot, pass 0 as `fov`.
---@param pos vec3 @Camera position.
---@param look vec3 @Camera direction.
---@param up vec3? @Camera vector facing upwards relative to camera. Default value: `vec3(0, 1, 0)`.
---@param fov number? @FOV in degrees. Default value: 90.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:update(pos, look, up, fov) end

---Returns a texture reference to a depth buffer (only if created with `withDepth` set to `true`), which you can use to draw
---depth buffer with something like `ui.image(shot:depth(), vec2(320, 160))`.
---
---Note: buffer is treated like a single-channel texture so it would show in red, but with `ui.setShadingOffset()` you can draw
---it differently.
---@return string
function _ac_GeometryShot:depth() end

---Clears texture.
---@param col rgbm
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:clear(col) end

---Generates MIPs. Once called, switches texture to manual MIPs generating mode. Note: this operation is not that expensive, but it’s not free.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:mipsUpdate() end

---Enables or disables transparent pass (secondary drawing pass with transparent surfaces). Disabled by default.
---@param value boolean? @Set to `true` to enable transparent pass. Default value: `true`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setTransparentPass(value) end

---Enables original lighting (stops from switching to neutral lighting active by default). With original lighting,
---methods like `shot:setAmbientColor()` and `shot:setReflectionColor()` would no longer have an effect.
---
---Note: this is not working well currently with post-processing active, drawing HDR colors into LDR texture. 
---Better support for such things is coming a bit later.
---@param value boolean? @Set to `true` to enable original lighting. Default value: `true`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setOriginalLighting(value) end

---Enables sky in the shot. By default, sky is not drawn.
---
---Note: this is not working well currently with post-processing active, drawing HDR colors into LDR texture. 
---Better support for such things is coming a bit later.
---@param value boolean? @Set to `true` to enable sky. Default value: `true`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setSky(value) end

---Enables particles in the shot. By default, particles are not drawn.
---
---Note: this is not working well currently with post-processing active, drawing HDR colors into LDR texture. 
---Better support for such things is coming a bit later.
---@param value boolean? @Set to `true` to enable particles. Default value: `true`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setParticles(value) end

---Changes used shaders set. Switch to a set like `render.ShadersType.SampleColor` to access color of surface without any extra effects.
---@param type render.ShadersType? @Type of shaders set to use. Default value: `render.ShadersType.Simplified`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setShadersType(type) end

---Sets clipping planes. If clipping planes are too far apart, Z-fighting might occur. Note: to avoid Z-fighting, increasing
---nearby clipping plane distance helps much more.
---@param near boolean? @Nearby clipping plane in meters. Default value: 0.05.
---@param far boolean? @Far clipping plane in meters. Default value: 1000.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setClippingPlanes(near, far) end

---Sets orthogonal parameters.
---@param size vec2
---@param depth number
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setOrthogonalParams(size, depth) end

---Sets clear color to clear texture with before each update. Transparent by default.
---@param value rgbm @Clear color from 0 to 1. Initial value: `rgbm.colors.transparent`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setClearColor(value) end

---Sets ambient color used for general lighting.
---@param value rgbm @Ambient color. Initial value: `rgbm(3, 3, 3, 1)`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setAmbientColor(value) end

---Sets color for reflection gradient.
---@param zenith rgbm @Zenith reflection color. Initial value: `rgbm(1, 1, 1, 1)`.
---@param horizon rgbm @Horizon reflection color. Initial value: `rgbm(0, 0, 0, 1)`.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:setReflectionColor(zenith, horizon) end

---Returns texture resolution (or zeroes if element has been disposed).
---@return vec2
function _ac_GeometryShot:size() end

---Returns number of MIP maps (1 for no MIP maps and it being a regular texture).
---@return integer
function _ac_GeometryShot:mips() end

---Manually applies antialiasing to the texture (works only if it was created with a specific antialiasing mode).
---By default antialiasing is applied automatically, but calling this function switches AA to a manual mode.
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:applyAntialiasing() end

---Saves shot as an image.
---@param filename string @Destination filename.
---@param format ac.ImageFormat? @Texture format (by default guessed based on texture name).
---@return ac.GeometryShot @Returns itself for chaining several methods together.
function _ac_GeometryShot:save(filename, format) end

--[[ common/ac_display.lua ]]

---Display namespace with helper functions for creating dynamic textures.
display = {}

---Draw a rectangle.
---@param params {pos: vec2, size: vec2, color: rgbm}|"{ pos = vec2(), size = vec2(), color = rgbm.colors.white }" "Table with properties:\n- `pos` (`vec2`): Coordinates of the top left corner in pixels.\n- `size` (`vec2`): Size in pixels.\n- `color` (`rgbm`): Rectangle color."
function display.rect(params) end

---Draw an image.
---
---If you’re drawing a lot of different images, consider combining them into a single atlas and using
---`uvStart`/`uvEnd` to specify the region.
---@param params {image: string, pos: vec2, size: vec2, color: rgbm, uvStart: vec2, uvEnd: vec2}|"{\n  image = '',\n  pos = vec2(),\n  size = vec2(),\n  color = rgbm.colors.white,\n  uvStart = vec2(0, 0),\n  uvEnd = vec2(1, 1)\n}" "Table with properties:\n- `image` (`string`): Path to image to draw.\n- `pos` (`vec2`): Coordinates of the top left corner in pixels.\n- `size` (`vec2`): Size in pixels.\n- `color` (`rgbm`): Image will be multiplied by this color.\n- `uvStart` (`vec2`): UV coordinates of the top left corner.\n- `uvEnd` (`vec2`): UV coordinates of the bottom right corner."
function display.image(params) end

---Draw text using AC font.
---@param params {text: string, pos: vec2, letter: vec2, font: string, color: rgbm, alignment: number, width: number, spacing: number}|"{\n  text = '',\n  pos = vec2(),\n  letter = vec2(20, 40),\n  font = 'aria',\n  color = rgbm.colors.white,\n  alignment = 0,\n  width = 200,\n  spacing = 0\n}" "Table with properties:\n- `text` (`string`): Text to draw.\n- `pos` (`vec2`): Coordinates of the top left corner in pixels.\n- `letter` (`vec2`): Size of each letter.\n- `font` (`string`): AC font to draw text with, either from “content/fonts” or from a folder with a script (can refer to a subfolder).\n- `color` (`rgbm`): Text color.\n- `alignment` (`number`): 0 for left, 0.5 for center, 1 for middle, could be anything in-between. Set `width` as well so it would know in what area to align text.\n- `width` (`number`): Required for non-left alignment.\n- `spacing` (`number`): Additional offset between characters, could be either positive or negative."
function display.text(params) end

---Draw simple horizontal bar (like progress bar) consisting of several sections.
---@param params {text: string, pos: vec2, size: vec2, delta: number, activeColor: rgbm, inactiveColor: rgbm, total: integer, active: integer}|"{\n  text = '',\n  pos = vec2(),\n  size = vec2(200, 40),\n  delta = 8,\n  activeColor = rgbm.colors.white,\n  inactiveColor = rgbm.colors.transparent,\n  total = 12,\n  active = 8\n}" "Table with properties:\n- `text` (`string`): Text to draw.\n- `pos` (`vec2`): Coordinates of the top left corner of the bar in pixels.\n- `size` (`vec2`): Size of the whole bar.\n- `delta` (`number`): Distance between elements.\n- `activeColor` (`rgbm`): Active color.\n- `inactiveColor` (`rgbm`): Inactive color.\n- `total` (`integer`): Total number of sections.\n- `active` (`integer`): Number of active sections."
function display.horizontalBar(params) end

--[[ common/ac_particles.lua ]]

---Table with different types of emitters.
ac.Particles = {}

---Flame emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit flames.
---@param params {color: rgbm, size: number, temperatureMultiplier: number, flameIntensity: number}|"{\n  color = rgbm(0.5, 0.5, 0.5, 0.5),\n  size = 0.2,\n  temperatureMultiplier = 1,\n  flameIntensity = 0\n}" "Table with properties:\n- `color` (`rgbm`): Flame color multiplier (for red/yellow/blue adjustment use `temperatureMultiplier` instead).\n- `size` (`number`): Particles size. Default value: 0.2.\n- `temperatureMultiplier` (`number`): Temperature multipler to vary base color from red to blue. Default value: 1.\n- `flameIntensity` (`number`): Flame intensity affecting flame look and behaviour. Default value: 0."
---@return ac.Particles.Flame
function ac.Particles.Flame(params) end

---Flame emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit flames.
---@class ac.Particles.Flame
---@field color rgbm @Flame color multiplier (for red/yellow/blue adjustment use `temperatureMultiplier` instead).
---@field size number @Particles size. Default value: 0.2.
---@field temperatureMultiplier number @Temperature multipler to vary base color from red to blue. Default value: 1.
---@field flameIntensity number @Flame intensity affecting flame look and behaviour. Default value: 0.
---@field carIndex number @0-based index of a car associated with flame emitter (affects final look).
local _ac_Particles_Flame = nil

---Emits flames from given position with certain velocity.
function _ac_Particles_Flame:emit(position, velocity, amount) end

---Sparks emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit sparks.
---@param params {color: rgbm, life: number, size: number, directionSpread: number, positionSpread: number}|"{\n  color = rgbm(0.5, 0.5, 0.5, 0.5),\n  life = 4,\n  size = 0.2,\n  directionSpread = 1,\n  positionSpread = 0.2\n}" "Table with properties:\n- `color` (`rgbm`): Sparks color.\n- `life` (`number`): Base lifetime. Default value: 4.\n- `size` (`number`): Base size. Default value: 0.2.\n- `directionSpread` (`number`): How much sparks directions vary. Default value: 1.\n- `positionSpread` (`number`): How much sparks position vary. Default value: 0.2."
---@return ac.Particles.Sparks
function ac.Particles.Sparks(params) end

---Sparks emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit sparks.
---@class ac.Particles.Sparks
---@field color rgbm @Sparks color.
---@field life number @Base lifetime. Default value: 4.
---@field size number @Base size. Default value: 0.2.
---@field directionSpread number @How much sparks directions vary. Default value: 1.
---@field positionSpread number @How much sparks position vary. Default value: 0.2.
local _ac_Particles_Sparks = nil

---Emits sparks from given position with certain velocity.
function _ac_Particles_Sparks:emit(position, velocity, amount) end

---Smoke emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit smoke.
---@param params {color: rgbm, colorConsistency: number, thickness: number, life: number, size: number, spreadK: number, growK: number, targetYVelocity: number}|"{\n  color = rgbm(0.5, 0.5, 0.5, 0.5),\n  colorConsistency = 0.5,\n  thickness = 1,\n  life = 4,\n  size = 0.2,\n  spreadK = 1,\n  growK = 1,\n  targetYVelocity = 0\n}" "Table with properties:\n- `color` (`rgbm`): Smoke color with values from 0 to 1. Alpha can be used to adjust thickness. Default alpha value: 0.5.\n- `colorConsistency` (`number`): Defines how much color dissipates when smoke expands, from 0 to 1. Default value: 0.5.\n- `thickness` (`number`): How thick is smoke, from 0 to 1. Default value: 1.\n- `life` (`number`): Smoke base lifespan in seconds. Default value: 4.\n- `size` (`number`): Starting particle size in meters. Default value: 0.2.\n- `spreadK` (`number`): How randomized is smoke spawn (mostly, speed and direction). Default value: 1.\n- `growK` (`number`): How fast smoke expands. Default value: 1.\n- `targetYVelocity` (`number`): Neutral vertical velocity. Set above zero for hot gasses and below zero for cold, to collect at the bottom. Default value: 0."
---@return ac.Particles.Smoke
function ac.Particles.Smoke(params) end

---Smoke emitter holding specialized settings. Set settings in a table when creating an emitter and/or change them later.
---Use `:emit(position, velocity, amount)` to actually emit smoke.
---@class ac.Particles.Smoke
---@field color rgbm @Smoke color with values from 0 to 1. Alpha can be used to adjust thickness. Default alpha value: 0.5.
---@field colorConsistency number @Defines how much color dissipates when smoke expands, from 0 to 1. Default value: 0.5.
---@field thickness number @How thick is smoke, from 0 to 1. Default value: 1.
---@field life number @Smoke base lifespan in seconds. Default value: 4.
---@field size number @Starting particle size in meters. Default value: 0.2.
---@field spreadK number @How randomized is smoke spawn (mostly, speed and direction). Default value: 1.
---@field growK number @How fast smoke expands. Default value: 1.
---@field targetYVelocity number @Neutral vertical velocity. Set above zero for hot gasses and below zero for cold, to collect at the bottom. Default value: 0.
local _ac_Particles_Smoke = nil

---Emits smoke from given position with certain velocity.
function _ac_Particles_Smoke:emit(position, velocity, amount) end

---Particles detractor pushing smoke (and othe particles later) away. Move it somewhere, set radius
---and velocity and it would affect the smoke.
---
---Note: use carefully, smoke particles can only account for eight detractors at once, and some of them can be set
---by track config. Also, moving cars or exhaust flames push smoke away using the same system.
---@param params {position: vec3, velocity: vec3, radius: number, forceMultiplier: number}|"{ radius = 10, forceMultiplier = 1 }" "Table with properties:\n- `position` (`vec3`): Detractor position.\n- `velocity` (`vec3`): Detractor velocity (main value that is used to push particles; stationary detractors don’t have much effect).\n- `radius` (`number`): Radius of the effect.\n- `forceMultiplier` (`number`): Force multiplier of the effect."
---@return ac.Particles.Detractor
function ac.Particles.Detractor(params) end

---Particles detractor pushing smoke (and othe particles later) away. Move it somewhere, set radius
---and velocity and it would affect the smoke.
---
---Note: use carefully, smoke particles can only account for eight detractors at once, and some of them can be set
---by track config. Also, moving cars or exhaust flames push smoke away using the same system.
---@class ac.Particles.Detractor
---@field position vec3 @Detractor position.
---@field velocity vec3 @Detractor velocity (main value that is used to push particles; stationary detractors don’t have much effect).
---@field radius number @Radius of the effect. Default value: 10.
---@field forceMultiplier number @Force multiplier of the effect. Default value: 1.
local _ac_Particles_Detractor = nil

--[[ common/ac_physics.lua ]]

---State of car controls.
---@class physics.CarControls
---@field gas number @Gas from 0 to 1 (pedal is fully pressed with 1).
---@field brake number @Braking from 0 to 1 (pedal is fully pressed with 1).
---@field steer number @Steering angle from -1 to 1.
---@field clutch number @1 for fully depressed clutch pedal (clutch fully engaged), 0 for pedal fully pressed (and clutch disengaged).
---@field gearUp boolean
---@field gearDown boolean
---@field drs boolean
---@field kers boolean
---@field brakeBalanceUp boolean
---@field brakeBalanceDown boolean
---@field requestedGearIndex integer
---@field isShifterSupported boolean
---@field handbrake number
---@field absUp boolean
---@field absDown boolean
---@field tcUp boolean
---@field tcDown boolean
---@field turboUp boolean
---@field turboDown boolean
---@field engineBrakeUp boolean
---@field engineBrakeDown boolean
---@field mgukDeliveryUp boolean
---@field mgukDeliveryDown boolean
---@field mgukRecoveryUp boolean
---@field mgukRecoveryDown boolean
---@field mguhMode integer
local _carControls = {}

--[[ common/ac_physics.lua ]]

---Physics namespace. Note: functions here are accessible only if track has expicitly allowed it with its
---extended CSP physics.
---
---To allow scriptable physics, add to surfaces.ini:
---```ini
---[_SCRIPTING_PHYSICS]
---ALLOW_TRACK_SCRIPTS=1    ; choose ones that you need
---ALLOW_DISPLAY_SCRIPTS=1
---ALLOW_NEW_MODE_SCRIPTS=1
---ALLOW_TOOLS=1
---```
---
---And to activate extended physics, use:
---```ini
---[SURFACE_0]
---WAV_PITCH=extended-0
---```
physics = {}

---Represents a physics rigid body. Requires double precision physics engine to work.
---@class physics.RigidBody
local _physics_RigidBody = nil

---Removes rigid body from the world.
function _physics_RigidBody:dispose() end

---Sets collision callback for semidynamic rigid bodies.
---@param callback fun()
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:onCollision(callback) end

---@param transform mat4x4
---@param estimateVelocity boolean? @Default value: `false`.
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setTransformation(transform, estimateVelocity) end

---@param sceneReference ac.SceneReference
---@param localTransform mat4x4?
---@param estimateVelocity boolean? @Default value: `false`.
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setTransformationFrom(sceneReference, localTransform, estimateVelocity) end

---@param velocity vec3
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setVelocity(velocity) end

---@param velocity vec3
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setAngularVelocity(velocity) end

---@param linear number
---@param angular number
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setDamping(linear, angular) end

---@param mass number
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setMass(mass) end

---@param value boolean|`true`|`false`
---@param switchBackOnContact boolean|`true`|`false`
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setSemiDynamic(value, switchBackOnContact) end

---@return boolean
function _physics_RigidBody:isSemiDynamic() end

---Stops rigidbody, collider is still working.
---@param value boolean|`true`|`false`
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setEnabled(value) end

---@return boolean
function _physics_RigidBody:isEnabled() end

---Stops rigidbody and removes collider from the world.
---@param value boolean|`true`|`false`
---@return physics.RigidBody @Returns self for easy chaining.
function _physics_RigidBody:setInWorld(value) end

---@return boolean
function _physics_RigidBody:isInWorld() end

---@return number
function _physics_RigidBody:getSpeedKmh() end

---@return number
function _physics_RigidBody:getAngularSpeed() end

---@return vec3
function _physics_RigidBody:getVelocity() end

---@return vec3
function _physics_RigidBody:getAngularVelocity() end

---@return integer @Wraps to 0 after 255.
function _physics_RigidBody:getLastHitIndex() end

---@return vec3
function _physics_RigidBody:getLastHitPos() end

---@param force vec3
---@param forceLocal boolean|`true`|`false`
---@param pos vec3
---@param posLocal boolean|`true`|`false`
function _physics_RigidBody:addForce(force, forceLocal, pos, posLocal) end

---@param pos vec3
---@return vec3
function _physics_RigidBody:localPosToWorld(pos) end

---@param dir vec3
---@return vec3
function _physics_RigidBody:localDirToWorld(dir) end

---@param pos vec3
---@return vec3
function _physics_RigidBody:worldPosToLocal(pos) end

---@param dir vec3
---@return vec3
function _physics_RigidBody:worldDirToLocal(dir) end

---@param point vec3
---@param pointLocal boolean|`true`|`false`
---@param velocityLocal boolean|`true`|`false`
---@return vec3
function _physics_RigidBody:pointVelocity(point, pointLocal, velocityLocal) end

---@return mat4x4
function _physics_RigidBody:getTransformation() end

---@alias physics.ColliderType {type: string}

---Represents a physics rigid body. Requires double precision physics engine to work.
---@param collider string|physics.ColliderType[] @Collider KN5 filename, or a table listing geometric colliders (see `physics.Collider`).
---@param mass number @Mass in kg, can be changed later.
---@param cog vec3? @Center of gravity in collider model, can’t be changed later.
---@param semiDynamic boolean? @Semi-dynamic from the start. Default value: `false`.
---@param startsInWorld boolean? @Add to world from the start. Default value: `true`.
---@return physics.RigidBody
function physics.RigidBody(collider, mass, cog, semiDynamic, startsInWorld) end

---Different collider types.
physics.Collider = {}

---Box collider.
---@param size vec3
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Box(size, offset, look, up, debug) end

---Sphere collider.
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Sphere(radius, offset, debug) end

---Capsule collider (like cylinder, but instead of flat caps it has hemispheres and works a bit faster).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Capsule(length, radius, offset, look, debug) end

---Cylinder collider (slower than capsule, consider using capsule where appropriate).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Cylinder(length, radius, offset, look, debug) end

--[[ common/ac_gameplay.lua ]]

---Tries to grabs camera for script to control it. If successfull, returns instance of `ac.GrabbedCamera` which you can then use to
---move camera, rotate it and alter some of its properties like DOF, FOV or exposure. However, if any other scripts are
---controlling camera currently, returns `nil` and a detailed error message with the name of script currently holding camera (with
---the reason to do so if provided) as a second argument.
---@param reason string|nil @Optional comment for the reason for grabbing camera, to simplify possible conflicts resolution.
---@return ac.GrabbedCamera|nil
---@return nil|string
function ac.grabCamera(reason) end

---Camera holder, for scripts to move camera in their own custom way. Obtained by calling `ac.grabCamera()`. When script is done with
---its camera movement, call `:dispose()` to release camera back to Assetto Corsa. If any reference to an instance of active holder
---is lost and `ac.GrabbedCamera` gets garbage collected, camera is also released.
---
---To move camera, access `.transform` property and edit it directly, setting new camera position and orientation vectors. Note:
---although matrix gives you access to `.side` and `.up` vectors, you don’t have to set them explicitly: before applying, matrix
---gets normalized automatically to make sure camera would not end up with a broken matrix.
---
---If you want to transition camera smoothly, use `.ownShare` property. It defaults to 1, but if set to 0.5, for example,
---resulting camera position would be in the middle of camera position set by AC and camera position set by script. If below 1,
---AC would also update camera position based on its current mode, once `.ownShare` reaches 1, CSP would switch current camera mode
---to free camera (switching back to original camera mode once `.ownShare` gets smaller).
---@class ac.GrabbedCamera
---@field transform mat4x4 @Camera transformation which will be applied with the next frame.
---@field transformOriginal mat4x4 @Camera transformation from original AC camera behaviour. Use `.ownShare` to smoothly transition between two, or access it here directly.
---@field fov number @Vertical FOV to be applied next frame, in degrees. Note: it would not affect camera in VR mode.
---@field fovOriginal number @Original camera vertical FOV, in degrees.
---@field dofDistance number @DOF distance to be applied next frame, in meters. Has an effect if `.dofFactor` is above 0. Requires YEBIS to work.
---@field dofDistanceOriginal number @Original camera DOF distance, in degrees.
---@field dofFactor number @DOF factor to be applied next frame. To get DOF to work, set it to 1.
---@field dofFactorOriginal number @Original camera DOF factor.
---@field exposure number @Camera exposure to be applied next frame.
---@field exposureOriginal number @Original camera exposure.
---@field ownShare number @Value for mixing original and custom camera parameters. Default value: 1. If 0, camera is controlled by Assetto Corsa. If 1, parameters set in `ac.GrabbedCamera` are used. If 0.5, parameters are mixed evenly.
local _ac_GrabbedCamera = nil

---Returns `true` if camera holder is currently holding camera and was not disposed.
---@return boolean
function _ac_GrabbedCamera:active() end

---Releases held camera and allows Assetto Corsa to control camera as usual.
function _ac_GrabbedCamera:dispose() end

---Normalizes camera matrix (makes sure all direction vectors are orthogonal and have proper length). No need to call it explicitly:
---camera matrix would undergo normalization before applying anyway. But it could be helpful if you need to access normalized `.side`,
---for example, right after altering `.look`.
function _ac_GrabbedCamera:normalize() end

--[[ common/ac_game.lua ]]

---Driver seat parameters.
---@param position vec3 "Driver eyes position. Starting value is taken from “GRAPHICS/DRIVEREYES” from “car.ini”."
---@param pitch number "Pitch angle in degrees. Starting value is taken from “GRAPHICS/ON_BOARD_PITCH_ANGLE” from “car.ini”."
---@param yaw number "Yaw angle in degrees. Starting value is 0."
---@return ac.SeatParams
function ac.SeatParams(position, pitch, yaw) end

---Driver seat parameters.
---@class ac.SeatParams
---@field position vec3 @Driver eyes position. Starting value is taken from “GRAPHICS/DRIVEREYES” from “car.ini”.
---@field pitch number @Pitch angle in degrees. Starting value is taken from “GRAPHICS/ON_BOARD_PITCH_ANGLE” from “car.ini”.
---@field yaw number @Yaw angle in degrees. Starting value is 0.
local _ac_SeatParams = nil

---@alias ac.ControlButtonModifiers {ctrl: boolean, shift: boolean, alt: boolean, ignore: boolean, gamepad: boolean}

---For internal use.
---@param id string
---@param key ui.KeyIndex?
---@param modifiers ac.ControlButtonModifiers?
---@param repeatPeriod number?
---@return ac.ControlButton
function ac.ControlButton(id, key, modifiers, repeatPeriod) end

---For internal use.
---@class ac.ControlButton
local _ac_ControlButton = nil

---@return boolean
function _ac_ControlButton:configured() end

---@return boolean
function _ac_ControlButton:pressed() end

---@return boolean
function _ac_ControlButton:down() end

---@param value boolean? @Default value: `true`.
---@return ac.ControlButton
function _ac_ControlButton:setAlwaysActive(value) end

--[[ common/ac_car_control.lua ]]

---Stores Real Mirror parameters for a real view mirror.
---@return ac.RealMirrorParams
function ac.RealMirrorParams() end

---Stores Real Mirror parameters for a real view mirror.
---@class ac.RealMirrorParams
---@field rotation vec2 @Mirror tilt, X for horizontal and Y for vertical.
---@field fov number @Field of view angle in degrees, automatically guessed value: 10.
---@field aspectMultiplier number @Aspect ratio multiplier.
---@field flip ac.MirrorPieceFlip @Optional texture mapping flip parameter.
---@field isMonitor boolean @Monitor mirrors don’t reflect car they’re in.
---@field useMonitorShader boolean @Monitor shader has brightness that works slightly differently, a bit of color distortion at steep view angles (depends on monitor type) and a pixel grid if viewed really close.
---@field role ac.MirrorPieceRole @Role of mirror piece. Used by adaptive virtual mirrors.
---@field monitorShaderScale vec2 @Scale of pixels grid for monitor shader. Automatically guessed value: `vec2(600, 150)`. Think of it as display resolution.
---@field monitorShaderSkew number @Skew of pixels grid to align pixels with tilted monitors.
---@field monitorShaderType ac.MirrorMonitorType @Type of monitor shader. By default guessed based on manufacturing year.
local _ac_RealMirrorParams = nil

---@return ac.RealMirrorParams
function _ac_RealMirrorParams:clone() end

---Returns set of mirror settings for a given Real Mirror mirror (for car scripts, associated car, for apps and tools — player’s car).
---@param mirrorIndex integer @0-based mirror index (leftmost mirror is 0, the first one to right of it is 1 and so on)
---@return ac.RealMirrorParams
function ac.getRealMirrorParams(mirrorIndex) end
