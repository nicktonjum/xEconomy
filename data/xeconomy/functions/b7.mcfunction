scoreboard players add @s color 1
kill @e[tag=xlock,limit=1,sort=nearest]
execute as @s[tag=sellx] run tag @s add buyx
execute as @s[tag=sellx] run tag @s add delb
execute as @s[tag=sellx] run tag @s remove sellx
execute as @s[tag=buyx,tag=!delb] run tag @s add sellx
execute as @s[tag=buyx,tag=!delb] run tag @s remove buyx
execute as @s[tag=buyx,tag=!delb] run tag @s add delb
tag @s remove delb
scoreboard players set @s b7 0