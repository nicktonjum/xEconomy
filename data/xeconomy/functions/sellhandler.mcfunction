execute as @s at @s store result score @p[tag=xshopper] checksum1 run data get entity @p[tag=xshopper] SelectedItem
execute as @s at @s store result score @p[tag=xshopper] checksum2 run data get entity @p[tag=xshopper] SelectedItem.id
execute as @s at @s store result score @p[tag=xshopper] checksum3 run data get entity @p[tag=xshopper] SelectedItem.Count
execute as @s at @s store result score @p[tag=xshopper] checksum4 run data get entity @p[tag=xshopper] SelectedItem.tag
execute as @s at @s store result score @p[tag=xshopper] checkcount run data get entity @p[tag=xshopper] SelectedItem.Count
execute as @s at @s store result score @s checksum1 run data get block ^ ^ ^-1 Items[9]
execute as @s at @s run scoreboard players remove @s checksum1 1
execute as @s at @s store result score @s checksum2 run data get block ^ ^ ^-1 Items[9].id
execute as @s at @s store result score @s checksum3 run data get block ^ ^ ^-1 Items[9].Count
execute as @s at @s store result score @s checksum4 run data get block ^ ^ ^-1 Items[9].tag
execute as @s at @s store result score @s checkcount run data get block ^ ^ ^-1 Items[9].Count
execute as @s at @s if score @p[tag=xshopper] checksum1 = @s checksum1 if score @p[tag=xshopper] checksum2 = @s checksum2 if score @p[tag=xshopper] checksum4 = @s checksum4 run tag @s add check1
execute as @s[tag=check1] at @s store result score @s availslot run data get block ^ ^ ^-1 Items
execute as @s[tag=check1] at @s unless score @s availslot matches 27 if score @p[tag=xshopper] checkcount >= @s shopcount run tag @s add check2
execute as @s[tag=check1] at @s if score @s availslot matches 27 run tellraw @p[tag=xshopper] {"text":"This shop is full!","color":"red"}
execute as @s[tag=check1] at @s unless score @p[tag=xshopper] checkcount >= @s shopcount run tellraw @p[tag=xshopper] {"text":"You don't have enough items in your hand!","color":"red"}
execute as @s[tag=check2] at @s if score @s shopmoney >= @s shopprice run tag @s add check3
execute as @s[tag=check2] at @s unless score @s shopmoney >= @s shopprice run tellraw @p[tag=xshopper] {"text":"This shop can't afford to buy from you!","color":"red"}
execute as @s[tag=check3] at @s run data modify storage xec raw set from entity @p[tag=xshopper] SelectedItem
execute as @s[tag=check3] at @s run data modify block ^ ^ ^-1 Items prepend from entity @p[tag=xshopper] SelectedItem
execute as @s[tag=check3] at @s run replaceitem entity @p[tag=xshopper] weapon air
execute as @s[tag=check3] at @s store result storage xec raw.Count byte 1 run scoreboard players operation @p[tag=xshopper] checkcount -= @s shopcount
execute as @s[tag=check3] at @s run summon item ~ ~ ~ {Item:{id:"minecraft:stone",Count:1b}}
execute as @s[tag=check3] at @s run data modify entity @e[type=item,limit=1,sort=nearest] Item set from storage xec raw
execute as @s[tag=check3] at @s run tp @e[type=item,limit=1,sort=nearest,distance=..1] @p[tag=xshopper]
execute as @s[tag=check3] at @s run tellraw @p[tag=xshopper] ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"},{"text":" has been added to your account.","color":"green"}]
execute as @s[tag=check3] at @s if block ^ ^ ^-2 repeater[facing=east,powered=false] run setblock ^ ^ ^-2 repeater[facing=east,powered=true]
execute as @s[tag=check3] at @s if block ^ ^ ^-2 repeater[facing=north,powered=false] run setblock ^ ^ ^-2 repeater[facing=north,powered=true]
execute as @s[tag=check3] at @s if block ^ ^ ^-2 repeater[facing=south,powered=false] run setblock ^ ^ ^-2 repeater[facing=south,powered=true]
execute as @s[tag=check3] at @s if block ^ ^ ^-2 repeater[facing=west,powered=false] run setblock ^ ^ ^-2 repeater[facing=west,powered=true]
execute as @s[tag=check3] at @s run tag @s add redtrigger
execute as @s[tag=check3] at @s run scoreboard players operation @s shopmoney -= @s shopprice
execute as @s[tag=check3] at @s run scoreboard players operation @p[tag=xshopper] balance += @s shopprice
execute as @s[tag=check3] at @s run data modify storage xec cache set from block ^ ^ ^-1 Items[9]
execute as @s[tag=check3,scores={checksum1=3..}] at @s store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot
execute as @s[tag=check3,scores={checksum1=3..}] at @s store result storage xec cache.Count byte 1 run scoreboard players get @s shopcount
execute as @s[tag=check3,scores={checksum1=3..}] at @s run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2}] at @s store result score @s xinsert run scoreboard players get @s shopcount

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[9].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[9].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[10].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[10].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[10].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[10].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[11].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[11].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[11].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[11].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[12].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[12].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[12].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[12].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[13].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[13].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[13].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[13].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[14].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[14].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[14].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[14].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[15].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[15].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[15].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[15].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[16].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[16].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[16].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[16].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[17].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[17].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[17].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[17].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[18].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[18].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[18].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[18].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[19].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[19].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[19].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[19].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[20].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[20].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[20].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[20].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[21].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[21].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[21].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[21].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[22].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[22].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[22].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[22].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[23].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[23].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[23].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[23].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[24].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[24].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[24].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[24].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[25].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[25].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[25].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[25].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[26].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[26].Count
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players set temp xcurrent 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[26].Count byte 1 run scoreboard players get @s xcurrent
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[26].Count set value 64
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @s[tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[27].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent
