scoreboard players remove @s shopprice 1
execute unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
tellraw @p[scores={b4=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
scoreboard players set @s b4 0