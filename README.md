Dell AlienWare Flash Project - 1115
=============

The project consists of 6 Flash Builder projects.

You may download the latest version from here:
https://github.com/jerryorta/1115-product-launch-aw-17-ranger-flash/releases



Updating the Adobe AIR SDK in Flash Builder:
=============
This project is programmed to use the AIR SDK. If you don't have the latest sdk in Flash Builder, You can download it from here:
http://www.adobe.com/devnet/air/air-sdk-download.html

or here:
https://creative.adobe.com/products/gaming-sdk

Once you have it downloaded, you need to replace the SDK in FlashBuilder.

In a folder similar to this (the final directory will be different), copy ALL of it’s contents:
C:\Program Files (x86)\Adobe Gaming SDK 1.1\AIR SDK\air3.7_sdk_asc2_win_033013

And place into this folder (empty it first).
C:\Program Files\Adobe\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flash.compiler_4.7.0.349722\AIRSDK
If for some reason this folder doesn’t exist on your system, you may find it in Flash Builder by navigating to:
Window > Preferences > Flash Builder > Installed AIR SDK

Once you copied the latest AIR SDK in the folder, you should see “AIR SDK 3.8 is being used…” in that same window.


Loading into Flash Builder:
=============
Set the workout space to the parent folder of the projects.
Import every project:

  File > Import Flash Builder Project... > File Folder > [Navigate to the project to import]


Before your compile a project:
=============
Launch mongoose_web_server.exe by double clicking on it. This is a localhost server mapped to the workspace directory. This is
preferred over the native sandbox Flash Builder uses, and each project is configured to use this server. You will
see in the url "http://localhost:8080/out/...." rather than "file:///....".

If you want to use the native Flash Builder sandbox, change the properties here:
Right click on the project, select "properties"
Select ActgionScript Build Path in the left nav
Delete the contents in the "Output folder URL:" field at the bottom.

Add "http://localhost:8080/out/" to this field if you want to use the mongoose server.


Each project is entirely self-contained, meaning there is not cross dependencies among the projects. BUT,
The Shell project requires all the other projects to be compiled to do subloads (duh, right?).

Each project outputs to the "out" folder in the workspace, instead of it's own project space, to save time 
copying and pasting files across directories.

Each project is huge, so it's best to close all projects except the one you are working on. You will have less compile and
memory issues this way.


