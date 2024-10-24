Notes:
    25/10:
        Level scenes are in ./Levels, should have a Node2D top level with the LevelManager.gd script.
        Most other scenes are in ./Environment
        Instantiate 2 or more Player scenes, check export vars and set one Player as Main and the other(s) as Shadow, and choose their mirrored directions (if needed)
        Instantiate 1 TileMap scene per Level scene (exceptions listed later):
            Generic tiles with minimal functionalities (such as basic ground blocks, or conveyor belts) are drawn normally using the basic texture atlas
            Some tiles with special functionalities (such as Mirror) may be drawn using the Scene Collection atlas instead 
            Other tiles that require specific behaviors/data **per tile** (such as a Key-Door combination) may only be instantiated manually in the editor without using the TileMap
        Current components/tiles to design levels with:
            Ground: basic terrain
            Mirror: merges 2 Shimmys if they both touch the mirror at roughly the same coordinates, currently teleports the main Shimmy to a designated Node2D named "Merged" in the level's scene tree. Has horizontal and vertical variants
            Conveyor belt: moves the Player(s) in the designated direction when stepped on
            Trampoline: bounces the Player **upwards** (meaning this *does not* work for Y-mirrored clones yet)
            Key: 1 Key corresponds to 1 Door. A Key is instantly picked up by the Player touching it (should be added to HUD maybe?) and will unlock only the Door that has an export var reference to this Key
            Door: 1 Door is actually a TileMap where you can draw the actual shape of the door/barrier, and then make this scene's children editable, then manually create a CollisionShape resource in its CollisionShape child to act as a detector for a Player with a Key
