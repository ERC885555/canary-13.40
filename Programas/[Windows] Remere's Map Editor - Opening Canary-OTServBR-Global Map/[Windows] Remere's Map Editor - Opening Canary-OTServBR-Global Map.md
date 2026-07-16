# [Windows] Remere's Map Editor - Opening Canary / OTServBR-Global Map

## Tutorial explaining how to open Canary or OTServBR-Global client id map with Remere's Map Editor.

### For Remere's Map Editor to work correctly you must have user and folder without accents and special characters.

## **1 - Downloads Required:**

**• Microsoft Visual C++ Redistributable 2017-2026:** ([32-bit download](https://aka.ms/vc14/vc_redist.x86.exe), [64-bit download](https://aka.ms/vc14/vc_redist.x64.exe))

**• Remere's Map Editor:** • [Download](https://github.com/opentibiabr/remeres-map-editor/releases/tag/v4.0)

**• Client 15:** • [Download](https://github.com/dudantas/tibia-client/releases/latest)

## **2 - Remere's Map Editor and Client 15:**

• Download and extract Remere's Map Editor into a folder.

• Download and extract the Client 15 into a folder.

## **3 - Opening the RME:**

• When opening the RME, it will ask the directory of version 15, just indicate the folder where the Client 15 was extracted. Your client folder should be like this:

* [Image 1](RME1.png)

• How to check client path:\
• File → Preferences:

* [Image 2](RME2.png)


• Preferences → Directories:

* [Image 3](RME3.png)


## **4 - Opening the Map:**

### **4.1 - Canary:**

* Go to option File → Open map and open the file canary.otbm.
* RME will open the map with the houses and respawns.
* If the map does not open, go to File → Import → Import Map.

### **4.2 - OTServBR-Global:**

* Go to option File → Open map and open the file otservbr.otbm.
* RME will open the map with the houses and respawns.
* If the map does not open, go to File → Import → Import Map.
* The map starts at coordinates x: 31912, y: 31021, z: 7.

## **5 -** Frequently Asked Questions

1 - In the temple of Thais, there are 2 teleports that are not on the original map, what to do?\
**Answer:** the teleports are loaded by the server on the custom map called **otservbr-custom.otbm,** this map is in **data-otservbr-global/world/custom** folder.

```
-- Custom Map
-- NOTE: toggleMapCustom set to true will load all maps in custom map folder
toggleMapCustom = true
```

**2 -** How can i convert my own map to client id?\
**Answer:** Download the tool to convert the map:\
<https://www.dropbox.com/s/25gxttf3c78n6mn/convert-map-to-client-id.zip?dl=1>\
• **Before converting your map to client id, for your security make a backup!**\
• Open your server id map;\
• Convert to client id;\
• Close the converter.

**3 -** How can i solve errors when i open my map?\
**Answer:** if you converted your own map to client id, you need to save one time to create the rootheaders (monsters and npcs) because in this RME the spawn is separated (monsters and npcs) and to fix your spawns you can see how the xml (monster.xml and npc.xml) are in the world folder of canary map.\
Your monster.xml should be like in this example:

```
<?xml version="1.0"?>
<monsters>
    <monster centerx="32383" centery="31998" centerz="8" radius="1">
        <monster name="Troll" x="1" y="1" z="8" spawntime="90" />
    </monster>
</monsters>
```

Your npc.xml should be like in this example:

```
<?xml version="1.0"?>
<npcs>
    <npc centerx="32104" centery="32190" centerz="6" radius="1">
        <npc name="The Oracle" x="0" y="0" z="6" spawntime="60" />
    </npc>
</npcs>
```

## **6 - Credits**

* **Majesty (RME Tutorial)**

* **hampusborgos and contributors (Original RME)**

* ***OpenTibiaBR and contributors (https://github.com/opentibiabr/remeres-map-editor/graphs/contributors)**
