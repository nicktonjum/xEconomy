execute as @e[tag=xecshop,scores={ownerid=0}] run kill @e[tag=xlock]
execute as @e[tag=xecshop,scores={ownerid=0}] run setblock ^ ^ ^-1 air replace
execute as @e[tag=xecshop,scores={ownerid=0}] run kill @s
execute as @a[scores={xid=0},tag=xidd] at @s run tag @s remove xidd
scoreboard players set zero xcurrent 0
scoreboard players enable @a deposit
execute as @e[tag=xecshop] at @s if block ^ ^-1 ^-1 hopper run setblock ^ ^-1 ^-1 air destroy
execute as @e[tag=xecadmin] at @s run scoreboard players set @s shopmoney 99999999
execute as @e[tag=xecadmin,tag=sellx] at @s run replaceitem block ^ ^ ^-1 container.10 air

execute as @e[tag=xecshop] at @s run kill @e[type=hopper_minecart,limit=1,distance=..2]
execute as @a[scores={deposit=1..}] at @s unless score @s balance >= @s deposit run tellraw @s {"text":"You can't afford that!","color":"red"}
execute as @a[scores={deposit=1..}] at @s unless score @s balance >= @s deposit run scoreboard players reset @s deposit
execute as @a[scores={deposit=1..}] at @s run scoreboard players operation @s balance -= @s deposit
execute as @a[scores={deposit=1..}] at @s run scoreboard players operation @e[tag=xecshop,limit=1,sort=nearest] shopmoney += @s deposit
execute as @a[scores={deposit=1..}] at @s run tellraw @s ["",{"text":"You deposited $","color":"green"},{"score":{"name":"@s","objective":"deposit"},"color":"green"},{"text":" into the shop.","color":"green"}]
execute as @a[scores={deposit=1..}] at @s run scoreboard players reset @s deposit

execute as @e[tag=xecshop] run tag @s remove check1
execute as @e[tag=xecshop] run tag @s remove check2
execute as @e[tag=xecshop] run tag @s remove check3
execute as @e[tag=xecshop] run tag @s remove check4
execute as @e[tag=xecshop] run tag @s remove check5
execute as @e[tag=xecshop] run tag @s remove check6
execute as @e[tag=xecshop] at @s unless score @s shopmoney matches -99999999..99999999 run scoreboard players set @s shopmoney 0
scoreboard players set xid searchx 0
scoreboard players set xidr searchx 0
scoreboard players enable @a paynearest
scoreboard players enable @a payxid
scoreboard players enable @a getxid
scoreboard players enable @a setpayxid

execute as @a[scores={setpayxid=1..}] run tellraw @s ["",{"text":"Searching for player with xID "},{"score":{"name":"@s","objective":"setpayxid"},"color":"gold"},{"text":"..."}]
execute as @a[scores={setpayxid=1..}] run scoreboard players operation @s selectedxid = @s setpayxid
execute as @a[scores={setpayxid=1..}] run scoreboard players operation xid searchx = @s setpayxid
execute as @a[scores={setpayxid=1..}] run scoreboard players set xidr searchx 0
execute as @a at @s if score @s xid = xid searchx run scoreboard players set xidr searchx 1
execute as @a at @s if score @s xid = xid searchx run tellraw @a[scores={setpayxid=1..}] ["",{"text":"Payment selected for player with xID "},{"score":{"name":"xid","objective":"searchx"},"color":"gold"},{"text":": "},{"selector":"@s"}]
execute unless score xidr searchx matches 1 run tellraw @p[scores={setpayxid=1..}] ["",{"text":"No player is online with xID "},{"score":{"name":"xid","objective":"searchx"},"color":"gold"},{"text":"."}]
execute as @a[scores={setpayxid=1..}] run scoreboard players reset @s setpayxid

execute as @a[scores={setpayxid=1..}] run scoreboard players operation xid searchx = @s setpayxid
execute as @a[scores={setpayxid=1..}] run scoreboard players operation @s selectedxid = @s setpayxid
execute as @a[scores={setpayxid=1..}] run scoreboard players reset @s setpayxid

execute as @a[scores={getxid=1..}] run tellraw @s ["",{"text":"Your xID is "},{"score":{"name":"@s","objective":"xid"},"color":"gold"}]
execute as @a[scores={getxid=1..}] run scoreboard players reset @s getxid

execute as @a[scores={payxid=1..}] run tellraw @s ["",{"text":"You sent $","color":"green"},{"score":{"name":"@s","objective":" payxid"},"color":"green"},{"text":" to xID ","color":"green"},{"score":{"name":"@s","objective":"selectedxid"},"color":"gold"},{"text":".","color":"green"}]
execute as @a[scores={payxid=1..}] run scoreboard players reset @s getxid

execute as @e[scores={paynearest=1..}] at @s unless score @s balance >= @s paynearest run tellraw @s ["",{"text":"You can't afford that!","color":"red"}]
execute as @e[scores={paynearest=1..}] at @s unless score @s balance >= @s paynearest run scoreboard players reset @s paynearest
execute as @e[scores={paynearest=1..}] at @s run tag @p[distance=0.1..] add xrecieve
execute as @e[scores={paynearest=1..}] at @s run tellraw @p[tag=xrecieve] ["",{"text":"You recieved $","color":"green"},{"score":{"name":"@s","objective":"paynearest"},"color":"green"},{"text":" from ","color":"green"},{"selector":"@s"}]
execute as @e[scores={paynearest=1..}] at @s run tellraw @s ["",{"text":"You paid $","color":"green"},{"score":{"name":"@s","objective":"paynearest"},"color":"green"},{"text":" to ","color":"green"},{"selector":"@p[tag=xrecieve]"}]
execute as @e[scores={paynearest=1..}] at @s run scoreboard players operation @p[tag=xrecieve] balance += @s paynearest
execute as @e[scores={paynearest=1..}] at @s run scoreboard players operation @s balance -= @s paynearest
execute as @e[scores={paynearest=1..}] at @s run tag @a remove xrecieve
execute as @e[scores={paynearest=1..}] at @s run scoreboard players reset @s paynearest

execute as @e[scores={payxid=1..}] at @s unless score @s balance >= @s payxid run tellraw @s ["",{"text":"You can't afford that!","color":"red"}]
execute as @e[scores={payxid=1..}] at @s unless score @s balance >= @s payxid run scoreboard players reset @s payxid

execute as @a[scores={payxid=1..}] run tellraw @s ["",{"text":"Searching for player with xID "},{"score":{"name":"@s","objective":"selectedxid"},"color":"gold"},{"text":"..."}]
execute as @a[scores={payxid=1..}] run scoreboard players operation xid searchx = @s selectedxid
execute as @a[scores={payxid=1..}] run scoreboard players set xidr searchx 0
execute as @a at @s if score @s xid = xid searchx run scoreboard players set xidr searchx 1

execute as @a at @s if score @s xid = xid searchx run tellraw @a[scores={payxid=1..}] ["",{"text":"You paid $","color":"green"},{"score":{"name":"@p[scores={payxid=1..}]","objective":"payxid"},"color":"green"},{"text":" to ","color":"green"},{"selector":"@s"}]
execute as @a at @s if score @s xid = xid searchx run tellraw @s ["",{"text":"You recieved $","color":"green"},{"score":{"name":"@p[scores={payxid=1..}]","objective":"payxid"},"color":"green"},{"text":" from ","color":"green"},{"selector":"@p[scores={payxid=1..}]"}]

execute as @a at @s if score @s xid = xid searchx run scoreboard players operation @s balance += @p[scores={payxid=1..}] payxid
execute as @a at @s if score @s xid = xid searchx run scoreboard players operation @p[scores={payxid=1..}] balance -= @p[scores={payxid=1..}] payxid


execute unless score xidr searchx matches 1 run tellraw @p[scores={setpayxid=1..}] ["",{"text":"No player is online with xID "},{"score":{"name":"xid","objective":"searchx"},"color":"gold"},{"text":"."}]
execute unless score xidr searchx matches 1 run scoreboard players reset @a[scores={payxid=1..}] payxid

execute as @a[scores={payxid=1..}] run scoreboard players reset @s payxid


execute as @e[tag=xecshop] at @s unless score @s color matches 0..17 run scoreboard players set @s color 0
execute as @e[tag=xecshop] at @s store result entity @e[tag=xlock,limit=1,sort=nearest,distance=..1] Color byte 0.5 run scoreboard players get @s color
execute as @e[tag=xlock] at @s unless block ~ ~ ~ chest run tag @s add xlremove
execute as @a at @s unless score @s balance matches -99999999..99999999 run scoreboard players set @s balance 0
tag @e[tag=ignorecommands] remove ignorecommands
scoreboard players enable @a bal
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 Items[9] run data modify entity @s Item set from block ^ ^ ^-1 Items[9]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:lime_wool"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:gray_wool"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:yellow_wool"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:red_wool"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:light_blue_wool"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @e[type=item,nbt={Item:{id:"minecraft:barrier"}}]
execute as @e[tag=xecshop] at @s unless block ^ ^ ^-1 chest run kill @s
execute as @p[tag=!xidd,limit=1] at @s run scoreboard players operation @s xid += static xid
execute as @p[tag=!xidd,limit=1] at @s run scoreboard players add static xid 1
execute as @p[tag=!xidd,limit=1] at @s run tag @s add xidd
execute as @e[type=item_frame,tag=!xecshop] at @s if block ^ ^ ^-1 minecraft:chest if data entity @s {Item:{id:"minecraft:oak_sign"}} run tag @s add xecsetup
execute as @e[type=item_frame,tag=!xecshop] at @s if block ^ ^ ^-1 minecraft:chest if data entity @s {Item:{id:"minecraft:debug_stick"}} run tag @s add xecadmin
execute as @e[type=item_frame,tag=!xecshop] at @s if block ^ ^ ^-1 minecraft:chest if data entity @s {Item:{id:"minecraft:debug_stick"}} run tag @s add xecsetup
execute as @e[tag=xecsetup] at @s run data merge entity @s {Item:{id:""},Invulnerable:1b,Silent:1b,Fixed:1b}
execute as @e[tag=xecsetup] at @s run tag @s add xecshop
execute as @e[tag=xecsetup] at @s run tag @s add buyx
execute as @e[tag=xecsetup] at @s run scoreboard players operation @s ownerid = @p xid
execute as @e[tag=xecsetup] at @s run particle explosion ~ ~ ~
execute as @e[tag=xecsetup] at @s run tag @s add ignorecommands
execute as @e[tag=xecsetup] at @s run tag @s remove xecsetup
execute as @e[tag=xecshop] at @s unless data block ^ ^ ^-1 Items[9] run data merge entity @s {Item:{id:"minecraft:barrier",Count:1b}}

execute as @e[x_rotation=90] run tag @s add showbal
execute as @e[tag=showbal] at @s run title @s actionbar ["",{"text":"Balance: $","bold":false,"italic":false,"color":"dark_green"},{"score":{"name":"@s ","objective":"balance"},"bold":false,"italic":false,"color":"dark_green"}]
execute as @e[x_rotation=..89,tag=showbal] run title @s actionbar {"text":""}
execute as @e[x_rotation=..89] run tag @s remove showbal
execute as @e[scores={bal=1..}] at @s run tellraw @s ["",{"text":"Balance: $","bold":false,"italic":false,"color":"green"},{"score":{"name":"@s ","objective":"balance"},"bold":false,"italic":false,"color":"green"}]
execute as @e[scores={bal=1..}] at @s run scoreboard players reset @s bal

execute as @e[tag=xecshop] at @s if score @p xshift matches 1.. if score @s ownerid = @p xid run data remove block ^ ^ ^-1 Lock
execute as @e[tag=xecshop] at @s if score @p xshift matches 1.. if score @s ownerid = @p xid run tag @s remove locked

execute as @e[tag=xecshop] at @s unless score @s ownerid = @p xid run data merge block ^ ^ ^-1 {Lock:'{"text":"Admin Key","color":"red","bold":"true"}'}
execute as @e[tag=xecshop] at @s unless score @s ownerid = @p xid run tag @s add locked
execute as @e[tag=xecshop] at @s unless score @p xshift matches 1.. run data merge block ^ ^ ^-1 {Lock:'{"text":"Admin Key","color":"red","bold":"true"}'}
execute as @e[tag=xecshop] at @s unless score @p xshift matches 1.. run tag @s add locked

execute as @e[tag=xecshop,tag=!locked] at @s run tag @e[tag=xlock,limit=1,sort=nearest,distance=..1] add xlremove
tp @e[tag=xlremove] ~ ~-10000 ~
kill @e[tag=xlremove]

execute as @e[tag=xecshop,tag=locked] at @s unless entity @e[tag=xlock,limit=1,sort=nearest,distance=..1] run summon minecraft:shulker ^ ^-0.5 ^-0.53 {Tags:["xlock"],Invulnerable:1b,NoAI:1b,Silent:1b}


scoreboard players reset @a xshift

execute as @a at @s store result score @s b1 run clear @s lime_wool{display:{Name:"{\"text\":\"+$1\",\"color\":\"green\"}"}}
execute as @a at @s store result score @s b2 run clear @s lime_wool{display:{Name:"{\"text\":\"+$10\",\"color\":\"green\"}"}}
execute as @a at @s store result score @s b3 run clear @s lime_wool{display:{Name:"{\"text\":\"+$100\",\"color\":\"green\"}"}}
execute as @a at @s store result score @s b4 run clear @s red_wool{display:{Name:"{\"text\":\"-$1\",\"color\":\"red\"}"}}
execute as @a at @s store result score @s b5 run clear @s red_wool{display:{Name:"{\"text\":\"-$10\",\"color\":\"red\"}"}}
execute as @a at @s store result score @s b6 run clear @s red_wool{display:{Name:"{\"text\":\"-$100\",\"color\":\"red\"}"}}
execute as @a at @s store result score @s b7 run clear @s light_blue_wool{display:{Name:"{\"text\":\"Buy Shop\",\"color\":\"aqua\"}"}}
execute as @a at @s store result score @s b8 run clear @s yellow_wool{display:{Name:"{\"text\":\"Sell Shop\",\"color\":\"yellow\"}"}}
execute as @a at @s store success score @s b9 run clear @s gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}}
execute as @a at @s store result score @s b10 run clear @s barrier{display:{Name:"{\"text\":\"Destroy Shop\",\"color\":\"red\"}"}}
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b1 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b2 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b3 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b4 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b5 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b6 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b7 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b8 1
execute as @e[tag=xecshop,tag=!ignorecommands] at @s run scoreboard players set @s b10 1
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:0b,id:"minecraft:lime_wool",Count:1b}]} run scoreboard players set @s b1 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:1b,id:"minecraft:lime_wool",Count:1b}]} run scoreboard players set @s b2 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:2b,id:"minecraft:lime_wool",Count:1b}]} run scoreboard players set @s b3 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:3b,id:"minecraft:red_wool",Count:1b}]} run scoreboard players set @s b4 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:4b,id:"minecraft:red_wool",Count:1b}]} run scoreboard players set @s b5 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:5b,id:"minecraft:red_wool",Count:1b}]} run scoreboard players set @s b6 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:7b,id:"minecraft:light_blue_wool",Count:1b}]} run scoreboard players set @s b7 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:7b,id:"minecraft:yellow_wool",Count:1b}]} run scoreboard players set @s b7 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:6b,id:"minecraft:gray_wool"}]} run scoreboard players set @s b8 0
execute as @e[tag=xecshop] at @s if data block ^ ^ ^-1 {Items:[{Slot:8b,id:"minecraft:barrier",Count:1b}]} run scoreboard players set @s b10 0

execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0

execute as @e[tag=xecshop,scores={b1=1}] run scoreboard players add @s shopprice 1
execute as @e[tag=xecshop,scores={b1=1}] run tellraw @p[scores={b1=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b2=1}] run scoreboard players add @s shopprice 10
execute as @e[tag=xecshop,scores={b2=1}] run tellraw @p[scores={b2=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b3=1}] run scoreboard players add @s shopprice 100
execute as @e[tag=xecshop,scores={b3=1}] run tellraw @p[scores={b3=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b4=1}] run scoreboard players remove @s shopprice 1
execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
execute as @e[tag=xecshop,scores={b4=1}] run tellraw @p[scores={b4=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b5=1}] run scoreboard players remove @s shopprice 10
execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
execute as @e[tag=xecshop,scores={b5=1}] run tellraw @p[scores={b5=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b6=1}] run scoreboard players remove @s shopprice 100
execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
execute as @e[tag=xecshop,scores={b6=1}] run tellraw @p[scores={b6=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
execute as @e[tag=xecshop,scores={b7=1}] run scoreboard players add @s color 1
execute as @e[tag=xecshop,scores={b7=1},tag=sellx] run tag @s add buyx
execute as @e[tag=xecshop,scores={b7=1},tag=sellx] run tag @s add delb
execute as @e[tag=xecshop,scores={b7=1},tag=sellx] run tag @s remove sellx
execute as @e[tag=xecshop,scores={b7=1},tag=buyx,tag=!delb] run tag @s add sellx
execute as @e[tag=xecshop,scores={b7=1},tag=buyx,tag=!delb] run tag @s remove buyx
execute as @e[tag=xecshop,scores={b7=1},tag=buyx,tag=!delb] run tag @s add delb
execute as @e[tag=xecshop,scores={b7=1}] run tag @s remove delb
execute as @e[tag=xecshop,scores={b7=1}] run scoreboard players set @s b7 0
execute as @e[tag=xecshop,scores={b8=1}] run scoreboard players add @s shopcountraw 1
execute as @e[tag=xecshop] at @s unless score @s shopcountraw matches -99999999..99999999 run scoreboard players set @s shopcount 1
execute as @e[tag=xecshop] at @s unless score @s shopcountraw matches -99999999..99999999 run scoreboard players set @s shopcountraw 1
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=1}] run scoreboard players set @s shopcount 1
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=2}] run scoreboard players set @s shopcount 2
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=3}] run scoreboard players set @s shopcount 4
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=4}] run scoreboard players set @s shopcount 8
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=5}] run scoreboard players set @s shopcount 16
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=6}] run scoreboard players set @s shopcount 32
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=7}] run scoreboard players set @s shopcount 64
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=8}] run scoreboard players set @s shopcount 1
execute as @e[tag=xecshop,scores={b8=1,shopcountraw=8}] run scoreboard players set @s shopcountraw 1
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.0 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.1 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.2 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.3 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.4 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.5 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.6 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.7 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run replaceitem block ^ ^ ^-1 container.8 air
execute as @e[tag=xecshop,scores={b10=1}] at @s run setblock ^ ^ ^-1 air destroy
execute as @e[tag=xecshop,scores={b10=1}] at @s run summon item ~ ~ ~ {Motion:[0.02,0.2,0.02],Item:{id:"minecraft:item_frame",Count:1b}}
execute as @e[tag=xecshop,scores={b10=1}] at @s run summon item ~ ~ ~ {Motion:[-0.02,0.2,-0.02],Item:{id:"minecraft:oak_sign",Count:1b}}
execute as @e[tag=xecshop,scores={b10=1}] run kill @s


execute as @e[tag=xecshop,scores={b1=1}] run scoreboard players set @s b1 0
execute as @e[tag=xecshop,scores={b2=1}] run scoreboard players set @s b2 0
execute as @e[tag=xecshop,scores={b3=1}] run scoreboard players set @s b3 0
execute as @e[tag=xecshop,scores={b4=1}] run scoreboard players set @s b4 0
execute as @e[tag=xecshop,scores={b5=1}] run scoreboard players set @s b5 0
execute as @e[tag=xecshop,scores={b6=1}] run scoreboard players set @s b6 0
execute as @e[tag=xecshop,scores={b7=1}] run scoreboard players set @s b7 0
execute as @e[tag=xecshop,scores={b8=1}] run scoreboard players set @s b8 0
execute as @e[tag=xecshop,scores={b10=1}] run scoreboard players set @s b10 0

execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.0 lime_wool{display:{Name:"{\"text\":\"+$1\",\"color\":\"green\"}"}}
execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.1 lime_wool{display:{Name:"{\"text\":\"+$10\",\"color\":\"green\"}"}}
execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.2 lime_wool{display:{Name:"{\"text\":\"+$100\",\"color\":\"green\"}"}}
execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.3 red_wool{display:{Name:"{\"text\":\"-$1\",\"color\":\"red\"}"}}
execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.4 red_wool{display:{Name:"{\"text\":\"-$10\",\"color\":\"red\"}"}}
execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.5 red_wool{display:{Name:"{\"text\":\"-$100\",\"color\":\"red\"}"}}
execute as @e[tag=xecshop,tag=buyx] at @s run replaceitem block ^ ^ ^-1 container.7 light_blue_wool{display:{Name:"{\"text\":\"Buy Shop\",\"color\":\"aqua\"}"}}
execute as @e[tag=xecshop,tag=sellx] at @s run replaceitem block ^ ^ ^-1 container.7 yellow_wool{display:{Name:"{\"text\":\"Sell Shop\",\"color\":\"yellow\"}"}}
execute as @e[tag=xecshop,scores={shopcountraw=1}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 1
execute as @e[tag=xecshop,scores={shopcountraw=2}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 2
execute as @e[tag=xecshop,scores={shopcountraw=3}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 4
execute as @e[tag=xecshop,scores={shopcountraw=4}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 8
execute as @e[tag=xecshop,scores={shopcountraw=5}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 16
execute as @e[tag=xecshop,scores={shopcountraw=6}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 32
execute as @e[tag=xecshop,scores={shopcountraw=7}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 64
execute as @e[tag=xecshop,scores={shopcountraw=8}] at @s run replaceitem block ^ ^ ^-1 container.6 gray_wool{display:{Name:"{\"text\":\"Item Count\",\"color\":\"white\"}"}} 1


execute as @e[tag=xecshop] at @s run replaceitem block ^ ^ ^-1 container.8 barrier{display:{Name:"{\"text\":\"Destroy Shop\",\"color\":\"red\"}"}}

execute as @e[tag=xecshop] at @s if data entity @s {ItemRotation:1b} run tag @s add xtrigger
execute as @e[tag=xtrigger] at @s run data merge entity @s {ItemRotation:0b}
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^1 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^1.5 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^2 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^2.5 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^3 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^3.5 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^4 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^4.5 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger] at @s run execute as @a[distance=..10] at @s anchored eyes positioned ^ ^ ^5 if entity @e[tag=xtrigger,distance=..2.5] run tag @s add xshopper
execute as @e[tag=xtrigger,tag=buyx] at @s store result score @s invcheck1 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=xtrigger,tag=buyx] at @s store result score @s invcheck2 run data get block ^ ^ ^-1 Items[10].Count
execute as @e[tag=xtrigger,tag=buyx] at @s store result score @s shopinventory run scoreboard players operation @s invcheck1 += @s invcheck2
execute as @e[tag=xtrigger,tag=buyx] at @s unless score @p[tag=xshopper] balance >= @s shopprice run tellraw @p[tag=xshopper] {"text":"You can't afford that!","color":"red"}
execute as @e[tag=xtrigger,tag=buyx] at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run summon item ~ ~ ~ {Item:{id:"minecraft:stone",Count:1b}}
execute as @e[tag=xtrigger,tag=buyx] at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run data modify entity @e[type=item,limit=1,sort=nearest] Item set from block ^ ^ ^-1 Items[9]
execute as @e[tag=xtrigger,tag=buyx] at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run data modify entity @e[type=item,limit=1,sort=nearest] Item.Count set from block ^ ^ ^-1 Items[6].Count
execute as @e[tag=xtrigger,tag=buyx] at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run tp @e[type=item,limit=1,sort=nearest] @p[tag=xshopper]
execute as @e[tag=xtrigger,tag=buyx] at @s if score @p[tag=xshopper] balance >= @s shopprice if data block ^ ^ ^-1 Items[9] if score @s shopinventory >= @s shopcount run tag @s add xremoveevent
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @p[tag=xshopper] checksum1 run data get entity @p[tag=xshopper] SelectedItem
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @p[tag=xshopper] checksum2 run data get entity @p[tag=xshopper] SelectedItem.id
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @p[tag=xshopper] checksum3 run data get entity @p[tag=xshopper] SelectedItem.Count
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @p[tag=xshopper] checksum4 run data get entity @p[tag=xshopper] SelectedItem.tag
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @p[tag=xshopper] checkcount run data get entity @p[tag=xshopper] SelectedItem.Count
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @s checksum1 run data get block ^ ^ ^-1 Items[9]
execute as @e[tag=xtrigger,tag=sellx] at @s run scoreboard players remove @s checksum1 1
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @s checksum2 run data get block ^ ^ ^-1 Items[9].id
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @s checksum3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @s checksum4 run data get block ^ ^ ^-1 Items[9].tag
execute as @e[tag=xtrigger,tag=sellx] at @s store result score @s checkcount run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=xtrigger,tag=sellx] at @s if score @p[tag=xshopper] checksum1 = @s checksum1 if score @p[tag=xshopper] checksum2 = @s checksum2 if score @p[tag=xshopper] checksum4 = @s checksum4 run tag @s add check1
execute as @e[tag=xtrigger,tag=sellx,tag=check1] at @s store result score @s availslot run data get block ^ ^ ^-1 Items
execute as @e[tag=xtrigger,tag=sellx,tag=check1] at @s unless score @s availslot matches 27 if score @p[tag=xshopper] checkcount >= @s shopcount run tag @s add check2
execute as @e[tag=xtrigger,tag=sellx,tag=check1] at @s if score @s availslot matches 27 run tellraw @p[tag=xshopper] {"text":"This shop is full!","color":"red"}
execute as @e[tag=xtrigger,tag=sellx,tag=check1] at @s unless score @p[tag=xshopper] checkcount >= @s shopcount run tellraw @p[tag=xshopper] {"text":"You don't have enough items in your hand!","color":"red"}
execute as @e[tag=xtrigger,tag=sellx,tag=check2] at @s if score @s shopmoney >= @s shopprice run tag @s add check3
execute as @e[tag=xtrigger,tag=sellx,tag=check2] at @s unless score @s shopmoney >= @s shopprice run tellraw @p[tag=xshopper] {"text":"This shop can't afford to buy from you!","color":"red"}
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run data modify storage xec raw set from entity @p[tag=xshopper] SelectedItem
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run data modify block ^ ^ ^-1 Items prepend from entity @p[tag=xshopper] SelectedItem
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run replaceitem entity @p[tag=xshopper] weapon air
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s store result storage xec raw.Count byte 1 run scoreboard players operation @p[tag=xshopper] checkcount -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run summon item ~ ~ ~ {Item:{id:"minecraft:stone",Count:1b}}
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run data modify entity @e[type=item,limit=1,sort=nearest] Item set from storage xec raw
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run tp @e[type=item,limit=1,sort=nearest] @p[tag=xshopper]
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run tellraw @p[tag=xshopper] ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"},{"text":" has been added to your account.","color":"green"}]
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run scoreboard players operation @s shopmoney -= @s shopprice
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run scoreboard players operation @p[tag=xshopper] balance += @s shopprice
execute as @e[tag=xtrigger,tag=sellx,tag=check3] at @s run data modify storage xec cache set from block ^ ^ ^-1 Items[9]
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=3..}] at @s store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=3..}] at @s store result storage xec cache.Count byte 1 run scoreboard players get @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=3..}] at @s run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2}] at @s store result score @s xinsert run scoreboard players get @s shopcount

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[9].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=10}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[10].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[10].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[10].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[10].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=11}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[11].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[11].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[11].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[11].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=12}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[12].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[12].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[12].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[12].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=13}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[13].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[13].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[13].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[13].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=14}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[14].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[14].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[14].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[14].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=15}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[15].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[15].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[15].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[15].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=16}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[16].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[16].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[16].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[16].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=17}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[17].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[17].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[17].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[17].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=18}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[18].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[18].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[18].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[18].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=19}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[19].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[19].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[19].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[19].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=20}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[20].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[20].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[20].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[20].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=21}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[21].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[21].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[21].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[21].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=22}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[22].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[22].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[22].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[22].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=23}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[23].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[23].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[23].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[23].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=24}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[24].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[24].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[24].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[24].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=25}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[25].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[25].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[25].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[25].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=26}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[26].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent

execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s store result score @s xcurrent run data get block ^ ^ ^-1 Items[26].Count
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players set temp xcurrent 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation temp xcurrent -= @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation temp xcurrent -= @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s run scoreboard players operation @s xcurrent += @s shopcount
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches 0.. store result block ^ ^ ^-1 Items[26].Count byte 1 run scoreboard players get @s xcurrent
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items[26].Count set value 64
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 store result storage xec cache.Slot byte 1 run scoreboard players get @s availslot 
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 run data modify block ^ ^ ^-1 Items append from storage xec cache
execute as @e[tag=xtrigger,tag=sellx,tag=check3,scores={checksum1=..2,xinsert=1..,availslot=27}] at @s if score temp xcurrent matches ..-1 store result block ^ ^ ^-1 Items[27].Count byte 1 run scoreboard players operation zero xcurrent -= temp xcurrent





execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent] at @s run tellraw @p[tag=xshopper] ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"},{"text":" has been removed from your account.","color":"green"}]
execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent] at @s run scoreboard players operation @p[tag=xshopper] balance -= @s shopprice
execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent,tag=!xecadmin] at @s run scoreboard players operation @s xbuyremove = @s shopcount
execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent] at @s run scoreboard players operation @s xbshopearn += @s shopprice
execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent] at @s run tag @s remove xremoveevent
execute as @e[tag=xtrigger] at @s run tag @a remove xshopper
execute as @e[tag=xtrigger] at @s run tag @s remove xtrigger
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result score @s invcheck3 run data get block ^ ^ ^-1 Items[9].Count
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s invcheck3 1
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s store result block ^ ^ ^-1 Items[9].Count byte 1 run scoreboard players get @s invcheck3
execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run scoreboard players remove @s xbuyremove 1
execute as @e[scores={xbshopearn=1..}] at @s if score @p xid = @s ownerid run tellraw @p ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"xbshopearn"},"color":"green"},{"text":" has been added to your account (from shop).","color":"green"}]
execute as @e[scores={xbshopearn=1..}] at @s if score @p xid = @s ownerid run scoreboard players operation @p balance += @s xbshopearn
execute as @e[scores={xbshopearn=1..}] at @s if score @p xid = @s ownerid run scoreboard players reset @s xbshopearn

execute as @e[scores={xbshopearn=1..}] at @s run tag @r add transcheck
execute as @e[scores={xbshopearn=1..}] at @s run execute if score @p[tag=transcheck] xid = @s ownerid run tellraw @p[tag=transcheck] ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"xbshopearn"},"color":"green"},{"text":" has been added to your account (from shop).","color":"green"}]
execute as @e[scores={xbshopearn=1..}] at @s run execute unless score @p[tag=transcheck] xid = @s ownerid run tag @a remove transcheck
execute as @e[scores={xbshopearn=1..}] at @s run execute if score @p[tag=transcheck] xid = @s ownerid run scoreboard players operation @p[tag=transcheck] balance += @s xbshopearn
execute as @e[scores={xbshopearn=1..}] at @s run execute if score @p[tag=transcheck] xid = @s ownerid run scoreboard players reset @s xbshopearn
execute as @a[tag=transcheck] run tag @s remove transcheck

execute as @a at @s anchored eyes positioned ^ ^ ^ if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s anchored eyes positioned ^ ^ ^1 if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s anchored eyes positioned ^ ^ ^2 if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s anchored eyes positioned ^ ^ ^3 if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s anchored eyes positioned ^ ^ ^4 if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s anchored eyes positioned ^ ^ ^5 if entity @e[tag=xecshop,limit=1,distance=..1.5] run scoreboard players set @s xmisc 1
execute as @a at @s run execute as @s at @s anchored eyes positioned ^ ^ ^ unless entity @e[tag=xecshop,limit=1,distance=..0.5] run execute as @s at @s anchored eyes positioned ^ ^ ^1 unless entity @e[tag=xecshop,limit=1,distance=..0.5] run execute as @s at @s anchored eyes positioned ^ ^ ^2 unless entity @e[tag=xecshop,limit=1,distance=..0.5] run execute as @s at @s anchored eyes positioned ^ ^ ^3 unless entity @e[tag=xecshop,limit=1,distance=..0.5] run execute as @s at @s anchored eyes positioned ^ ^ ^4 unless entity @e[tag=xecshop,limit=1,distance=..0.5] run execute as @s at @s anchored eyes positioned ^ ^ ^5 unless entity @e[tag=xecshop,limit=1,distance=..0.5] run scoreboard players reset @s xmisc
execute as @e[tag=xecshop] at @s unless score @s shopcount matches -999999999..999999999 run scoreboard players set @s shopamt 0
execute as @e[scores={xmisc=1..}] at @s run tag @s add sendinfo
execute as @e[tag=sendinfo] at @s anchored eyes run summon armor_stand ^ ^ ^0.5 {Invisible:1b,Small:1b,Invulnerable:1b,Marker:1b,Tags:["xtracer"]}
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes facing entity @p[tag=sendinfo] eyes run tp ~ ~ ~
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s anchored eyes run tp ^ ^ ^-0.5
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=buyx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to buy ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=sellx,distance=..0.5] run title @p[tag=sendinfo] actionbar ["",{"text":"["},{"text":"xEconomy Shop","color":"gold"},{"text":"] ","color":"none"},{"text":"Right click to sell ","color":"dark_green"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopcount"},"color":"blue"},{"text":" item(s) for ","color":"dark_green"},{"text":"$","color":"blue"},{"score":{"name":"@e[tag=xecshop,distance=..1,sort=nearest,limit=1]","objective":"shopprice"},"color":"blue"}]
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run scoreboard players set @p[tag=sendinfo] showinfo 1
execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s if entity @e[tag=xecshop,distance=..0.5] run kill @s

execute as @e[tag=sendinfo] at @s run execute as @e[tag=xtracer] at @s run kill @s
execute as @e[tag=sendinfo] at @s run tag @s remove sendinfo









