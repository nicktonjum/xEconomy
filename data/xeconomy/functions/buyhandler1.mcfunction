execute as @s at @s store result score @s invcheck1 run data get block ^ ^ ^-1 Items[9].Count
execute as @s at @s store result score @s invcheck2 run data get block ^ ^ ^-1 Items[10].Count
execute as @s at @s store result score @s shopinventory run scoreboard players operation @s invcheck1 += @s invcheck2
execute as @s at @s unless score @p[tag=xshopper] balance >= @s shopprice run tellraw @p[tag=xshopper] {"text":"You can't afford that!","color":"red"}
execute as @s at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run summon item ~ ~ ~ {Item:{id:"minecraft:stone",Count:1b}}
execute as @s at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run data modify entity @e[type=item,limit=1,sort=nearest] Item set from block ^ ^ ^-1 Items[9]
execute as @s at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run data modify entity @e[type=item,limit=1,sort=nearest] Item.Count set from block ^ ^ ^-1 Items[6].Count
execute as @s at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run tp @e[type=item,limit=1,sort=nearest] @p[tag=xshopper]
execute as @s at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run tag @s add xremoveevent
