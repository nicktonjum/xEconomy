execute as @s at @s run tellraw @p[tag=xshopper] ["",{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"},{"text":" has been removed from your account.","color":"green"}]
execute as @s at @s if block ^ ^ ^-2 repeater[facing=north] run setblock ^ ^ ^-2 repeater[facing=north,powered=true]
execute as @s at @s if block ^ ^ ^-2 repeater[facing=east] run setblock ^ ^ ^-2 repeater[facing=east,powered=true]
execute as @s at @s if block ^ ^ ^-2 repeater[facing=south] run setblock ^ ^ ^-2 repeater[facing=south,powered=true]
execute as @s at @s if block ^ ^ ^-2 repeater[facing=west] run setblock ^ ^ ^-2 repeater[facing=west,powered=true]

execute as @s at @s run tag @s add redtrigger
execute as @s at @s run scoreboard players operation @p[tag=xshopper] balance -= @s shopprice
execute as @s[tag=!xecadmin] at @s run scoreboard players operation @s xbuyremove = @s shopcount
execute as @s at @s run scoreboard players operation @s xbshopearn += @s shopprice
execute as @s at @s run tag @s remove xremoveevent