execute if score listid xsettings matches 1 run scoreboard objectives setdisplay list xid
execute if score raw xptrecords matches ..1200 run scoreboard players add raw xptrecords 1
execute if score raw xptrecords matches 1201 run scoreboard players set raw xptrecords 1
kill @e[type=item,nbt={Item:{id:"minecraft:barrier"}}]
execute as @a at @s if score enableplaytime xsettings matches 1 if score raw xptrecords matches 1200 run scoreboard players add @s xptrecords 1
execute as @a at @s if score enableplaytime xsettings matches 1 if score @s xptrecords >= ptrequirement xsettings run tellraw @s ["",{"text":"$","color":"green"},{"score":{"name":"ptpayout","objective":"xsettings"},"color":"green"},{"text":" has been added to your account for playtime.","color":"green"}]
execute as @a at @s if score enableplaytime xsettings matches 1 if score @s xptrecords >= ptrequirement xsettings run scoreboard players operation @s balance += ptpayout xsettings
execute as @a at @s if score enableplaytime xsettings matches 1 if score @s xptrecords >= ptrequirement xsettings run scoreboard players set @s xptrecords 0
execute as @e[tag=xecshop] at @s unless block ~ ~ ~ air run function xeconomy:b10
execute as @e[tag=buyx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=north] run setblock ^ ^ ^-2 repeater[powered=false,facing=north]
execute as @e[tag=buyx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=east] run setblock ^ ^ ^-2 repeater[powered=false,facing=east]
execute as @e[tag=buyx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=south] run setblock ^ ^ ^-2 repeater[powered=false,facing=south]
execute as @e[tag=buyx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=west] run setblock ^ ^ ^-2 repeater[powered=false,facing=west]
execute as @e[tag=sellx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=north] run setblock ^ ^ ^-2 repeater[powered=false,facing=north]
execute as @e[tag=sellx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=east] run setblock ^ ^ ^-2 repeater[powered=false,facing=east]
execute as @e[tag=sellx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=south] run setblock ^ ^ ^-2 repeater[powered=false,facing=south]
execute as @e[tag=sellx,tag=redtrigger] at @s if block ^ ^ ^-2 repeater[powered=true,facing=west] run setblock ^ ^ ^-2 repeater[powered=false,facing=west]
execute as @e[tag=redtrigger] at @s run tag @s remove redtrigger
execute if score plmsg xgeneral matches 0 run schedule function xeconomy:xplugin 1s
execute if score plmsg xgeneral matches 0 run scoreboard players set plmsg xgeneral 1
execute as @e[tag=xecshop,scores={ownerid=0}] run kill @e[tag=xlock]
execute as @e[tag=xecshop,scores={ownerid=0}] run setblock ^ ^ ^-1 air replace
execute as @e[tag=xecshop,scores={ownerid=0}] run kill @s
execute as @a[tag=xidd] at @s unless score @s xid matches 1.. run tag @s remove xidd
scoreboard players set zero xcurrent 0
scoreboard players enable @a deposit
execute as @e[tag=xecshop] at @s if block ^ ^-1 ^-1 hopper run setblock ^ ^-1 ^-1 air destroy
execute as @e[tag=xecadmin] at @s run scoreboard players set @s shopmoney 99999999
execute as @e[tag=xecadmin,tag=sellx] at @s run replaceitem block ^ ^ ^-1 container.10 air
execute as @a at @s store result score @s xgui run data get entity @s recipeBook.isGuiOpen
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



execute as @e[tag=xlock] at @s unless block ~ ~1 ~ chest run tag @s add xlremove
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
execute as @e[tag=xecsetup] at @s run data merge entity @s {Item:{id:""},Invulnerable:1b,Fixed:0b,Silent:1b}
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
kill @e[tag=xlremove]

function xeconomy:colorhandler

scoreboard players reset @a xshift

execute as @a at @s if entity @e[tag=xecshop,distance=..6] run function xeconomy:6guihandler

execute as @e[tag=xecshop,tag=!ignorecommands] run function xeconomy:ignorecommands

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

execute as @e[tag=xecshop,scores={b1=1}] run function xeconomy:b1
execute as @e[tag=xecshop,scores={b2=1}] run function xeconomy:b2
execute as @e[tag=xecshop,scores={b3=1}] run function xeconomy:b3
execute as @e[tag=xecshop,scores={b4=1}] run function xeconomy:b4

execute as @e[tag=xecshop,scores={b5=1}] run function xeconomy:b5
execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
execute as @e[tag=xecshop,scores={b6=1}] run function xeconomy:b6
execute as @e[tag=xecshop] at @s unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
execute as @e[tag=xecshop,scores={b7=1}] run function xeconomy:b7
execute as @e[tag=xecshop,scores={b8=1}] run function xeconomy:b8
execute as @e[tag=xecshop] at @s unless score @s shopcountraw matches -99999999..99999999 run scoreboard players set @s shopcount 1
execute as @e[tag=xecshop] at @s unless score @s shopcountraw matches -99999999..99999999 run scoreboard players set @s shopcountraw 1
execute as @e[tag=xecshop,scores={b10=1}] at @s run function xeconomy:b10

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
execute as @e[tag=xtrigger] at @s run function xeconomy:basetrigger

execute as @e[tag=xtrigger,tag=buyx] at @s run function xeconomy:buyhandler1
execute as @e[tag=xtrigger,tag=sellx] at @s run function xeconomy:sellhandler




execute as @e[tag=xtrigger,tag=buyx,tag=xremoveevent] at @s run function xeconomy:buyhandler2

execute as @e[tag=xtrigger] at @s run tag @a remove xshopper
execute as @e[tag=xtrigger] at @s run tag @s remove xtrigger

execute as @e[tag=buyx,scores={xbuyremove=1..}] at @s run function xeconomy:remover1
execute as @e[tag=xecadmin,scores={xbshopearn=1..}] at @s run scoreboard players reset @s xbshopearn
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
execute as @e[tag=sendinfo] at @s run function xeconomy:tracer1





