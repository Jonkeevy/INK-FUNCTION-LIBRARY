/*
[progress value={variable}]Inner text[/progress] 

Displays progress bar.
Attributes:
    value=x current progressbar value
    min=x minimal progressbar value
    max=x maximal progressbar value
    style=accent highlight progressbar with accent theme color
*/

// >>>>>>>>>>>>>>>>>>>>>> PRINT PROGRESS BARS <<<<<<<<<<<<<<<<<<<<<<<<<

=== function printPROGRESS(task)
~ temp min_value = 0
~ temp max_value = get_max(task)
~ temp current_value = get_current(task)
~ temp title_text = "{filter(task,taskALL)}"
~ temp image = inline_image_sorter(task)
{current_value < 1:
    ~ return
}

[banner]{image}[progress value={current_value} min={min_value} max={max_value}]{title_text}[/progress][/banner]

=== function get_current(task)
{check_overlap(task,taskPROG_5CYCLES): 
~ return LIST_VALUE(filter(task,taskPROG_5CYCLES)-1)
}

{check_overlap(task,taskPROG_10CYCLES): 
~ return LIST_VALUE(filter(task,taskPROG_10CYCLES)-1)
}

=== function get_max(task)
{check_overlap(task,taskPROG_5CYCLES): 
~ return 5
}

{check_overlap(task,taskPROG_10CYCLES): 
~ return 10
}

=== ProgessBars
[banner]Tasks[/banner]

{printPROGRESS(build_chapel)}
{printPROGRESS(do_simple_task)}
{printPROGRESS(do_complex_task)}
+ [ ]
#CLEAR
-
->->
