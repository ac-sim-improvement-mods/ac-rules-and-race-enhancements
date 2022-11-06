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

--[[ csp.lua ]]

---For any physics calculations avoid using structures provided by `ac.getCar()` and such: those update with graphics thread, so
--- not often enough, plus if graphics thread would experience a freeze that data might get very out of date.
---@return ac.StateCphysCarData
function ac.accessCarPhysics() end

---Adds force to a car body, invalidates current lap.
---@param position vec3 @Point of force application.
---@param posLocal boolean|`true`|`false` @If `true`, position is treated like position relative to car coordinates, otherwise as world position.
---@param force vec3 @Force vector in N.
---@param forceLocal boolean|`true`|`false` @If `true`, force is treated like vector relative to car coordinates, otherwise as world vector.
function ac.addForce(position, posLocal, force, forceLocal) end

---Updates position of a certain box collider.
---@param index integer
---@param offset vec3
---@return boolean @Returns `false` if there is no such collider.
function ac.setColliderOffset(index, offset) end

---Changes CD_GAIN and CL_GAIN of a wing, overriding values set in `aero.ini`.
---@param wingIndex integer
---@param cdGain number
---@param clGain number
function ac.setWingGain(wingIndex, cdGain, clGain) end

---Changes final gear ratio, can be overriden by setup if available.
---@param finalRatio number
function ac.setGearsFinalRatio(finalRatio) end

---Changes remaining engine life.
---@param grinding boolean|`true`|`false`
function ac.setGearsGrinding(grinding) end

---Changes shifting RPM window simulating gearbox damage.
---@param newValue number
function ac.setDrivetrainDamageRPMWindow(newValue) end

---@param frontShare number
function ac.setDrivetrainAWDFrontShare(frontShare) end

---Changes values of antiroll bars.
---@param kFront number
---@param kRear number
function ac.setAntirollBars(kFront, kRear) end

---Changes current RPM.
---@param newValue number
function ac.setEngineRPM(newValue) end

---Changes remaining engine life.
---@param newValue number @Value from 0 (broken engine) to 1000 (new one).
function ac.setEngineLifeLeft(newValue) end

---Enables or disables engine stalling. Engine with stall enabled wouldn’t automatically get extra RPM if engine is below certain
--- RPM. Note: if you’re using it for recreating manual engine start up, in the future it might lead to regular manual engine starting fix
--- applied to all cars getting disabled for yours.
---@param value boolean|`true`|`false`
function ac.setEngineStalling(value) end

---Changes tyre inflation.
---@param tyre integer
---@param inflation number @Set to 0 to blow up a tyre.
function ac.setTyreInflation(tyre, inflation) end

---You can also just use `car.turboWastegates[7]` if you less than 8 turbos.
---@param index integer
---@return number
function ac.getTurboUserWastegate(index) end

---Sets custom value for turbo wastegate (aka user setting).
---@param index integer
---@param value number
function ac.setTurboUserWastegate(index, value) end

---Change max turbo boost.
---@param index integer
---@param value number
function ac.setTurboMaxBoost(index, value) end

---Change turbo wastegate.
---@param index integer
---@param wastegate number
---@param isAdjustable boolean|`true`|`false`
function ac.setTurboWastegate(index, wastegate, isAdjustable) end

---Change extra turbo parameters.
---@param index integer
---@param lagUp number
---@param lagDown number
---@param referenceRpm number
---@param gamma number
function ac.setTurboExtras(index, lagUp, lagDown, referenceRpm, gamma) end

---Overrides turbo boost completely. Note: once used, original turbo logic would no longer apply, all original settings would
--- no longer matter (except for adjustable flag).
---@param index integer
---@param newBoost number @Pass not-a-number to revert to original turbo.
function ac.overrideTurboBoost(index, newBoost) end

---Returns a reference to a custom script setup item. If there is no item with such index, returns `nil`.
---@param id string @ID from section in “setup.ini”.
---@return refnumber?
function ac.getScriptSetupValue(id) end

---Changes value of a setup item by its ID.
---@param id string @ID from section in “setup.ini”.
---@param value number
---@return boolean @Returns `false` if there is no such item.
function ac.setScriptSetupValue(id, value) end

---Allows to access a dynamic controller in an INI file. If there is no such controller, returns `nil`.
---@param name string @For example, `'ctrl_script.ini'`.
---@return refnumber?
function ac.getDynamicController(name) end
---@class ac.StateCphysWheelData : ClassBase
---@field angularSpeed number
---@field slip number
---@field slipAngle number @Slip angle in radians.
---@field slipRatio number
---@field ndSlip number
---@field load number
---@field inflation number @For changing use `ac.setTyreInflation(tyreIndex, pressure)`

---@class ac.StateCphysCarData : ClassBase
---@field inputMethod ac.InputMethod
---@field gForces vec3
---@field localAngularVelocity vec3
---@field localVelocity vec3 @Car velocity relative to car.
---@field damageLevel number[] @4 items, starts with 0.
---@field speedKmh number
---@field ffb number
---@field rpm number @For changing use `ac.setEngineRPM()`
---@field engineLifeLeft number @For changing use `ac.setEngineLifeLeft()`
---@field drivetrainDamageRPMWindow number @For changing use `ac.setDrivetrainDamageRPMWindow()`
---@field drivetrainOriginalRPMWindow number
---@field antirollBarFront number
---@field antirollBarRear number
---@field gearsFinalRatio number
---@field absMode integer
---@field tractionControlMode integer
---@field gear integer
---@field tractionControlInAction boolean
---@field areControlsLocked boolean
---@field isEngineStallEnabled boolean @For changing use `ac.setEngineStalling()`
---@field isBlackFlagged boolean
---@field enforceCustomInputScheme boolean @If set to `true`, use custom input scheme even if input method is not wheel (if not possible, disable input entirely).
---@field isGearGrinding boolean @For changing use `ac.setGearsGrinding()`
---@field gas number @Can be changed (unless controls are locked or car has black flag).
---@field brake number @Can be changed (unless controls are locked or car has black flag).
---@field steer number @Can be changed (unless controls are locked or car has black flag).
---@field clutch number @Can be changed (unless controls are locked or car has black flag).
---@field handbrake number @Can be changed (unless controls are locked or car has black flag).
---@field requestedGearIndex integer @Can be changed (unless controls are locked or car has black flag).
---@field gearUp boolean @Can be changed (unless controls are locked or car has black flag).
---@field gearDown boolean @Can be changed (unless controls are locked or car has black flag).
---@field isShifterSupported boolean @Can be changed (unless controls are locked or car has black flag).
---@field controllerInputs number[] @Set values here and access them as SCRIPT_0...SCRIPT_7 inputs in dynamic controllers. For emissives and such, can be accessed as CPHYS_SCRIPT_0..., other Lua scripts can access via car physics state. 8 items, starts with 0.
---@field wheels ac.StateCphysWheelData[] @4 items, starts with 0.

--[[ ac_car_cphys.lua ]]

---Reference to information about state of associated car.
---@type ac.StateCar
car = nil

---Reference to information about state of simulation.
---@type ac.StateSim
sim = nil

---Note: joypad assist script runs from physics thread, so update rate is much higher. Please keep it in mind and keep
---code as fast as possible.
---@class ScriptData
---@single-instance
script = {}

---Called each physics frame.
---@param dt number @Time passed since last `update()` call, in seconds. Usually would be around 0.003.
function script.update(dt) end
