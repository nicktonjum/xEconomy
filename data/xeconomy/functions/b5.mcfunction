scoreboard players remove @s shopprice 10
execute unless score @s shopprice matches 0..99999999 run scoreboard players set @s shopprice 0
tellraw @p[scores={b5=1}] ["",{"text":"Shop price is now "},{"text":"$","color":"green"},{"score":{"name":"@s","objective":"shopprice"},"color":"green"}]
scoreboard players set @s b5 0