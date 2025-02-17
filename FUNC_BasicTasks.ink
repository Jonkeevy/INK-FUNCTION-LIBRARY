// >>>>>>>>>>>>>>>>>> BASIC TASKS <<<<<<<<<<<<<<<<<<<<<<
// 
// Basic tasks require:
// [X] - Task to do
// [X] - Thing/Person to do Task
// [X] - Time to do Task over
// [X] - Way to choose Task to do
// [X] - Way to Start Task
// [X] - Way to Finish Task
// [X] - Interrupt
// [X] - Reassign

// [ ] - See INK FUNCTION LIBRARY\FUNC_TechTree.ink for making unlocking tasks.


// >>>>>>>>>>>>>>>>>>> CYCLE TRACKING <<<<<<<<<<<<<<<<<<<

CONST maxCYCLES = 10
CONST maxACTION = 5

VAR currentCYCLE = 0
VAR remainingCYCLES = 0

// >>>>>>>>>>>>>>>>>> TASK VARIABLES <<<<<<<<<<<<<<<<<

LIST taskSTATES = (unknown), researching, available, in_progress, completed

LIST taskPROG_5CYCLES = 0of5, (1of5), (2of5), (3of5), (4of5), (5of5) // This is a task that takes 5 cycles

LIST taskPROG_10CYCLES = 0of10, (1of10), (2of10), (3of10), (4of10), (5of10), (6of10), (7of10), (8of10), (9of10), (10of10) // This is a task that takes 10 cycles

LIST taskALL = (chapel), (simple_task), complex_task
// All Tasks - the serial number really

VAR taskAVAILABLE = ()

//VAR taskRESEARCHABLE = (chapel, complex_task)

VAR build_chapel = (chapel, available, 0of5, hydroponics)
VAR do_simple_task = (simple_task, in_progress, 0of5, soap)
VAR do_complex_task = (complex_task, available, 0of10, hydroponics)
// Task specifics & place to hold progress and assign Task-Cook to 

VAR currentTASK = ()
VAR otherTASK = ()

LIST taskCOOKER = (cookONE), (cookTWO)

// >>>>>>>>>>>>>>>>>> FUNCTIONS FOR TASKS <<<<<<<<<<<<<<<<<
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// >>>>>>>>>>>>>>>>>> ADVANCING TASKS <<<<<<<<<<

=== function advanceTASK(ref task)
    {task ^ completed || task ^ unknown || task ^ researching:
        ~ return
        }

    {task ^ available && task ^ LIST_ALL(taskCOOKER):
        {filter(task,taskCOOKER)} has begun {filter(task,taskALL)}.
        ~ improve_trait(task, taskSTATES)
        ~ sorter_improve_progress_TASKDEMO(task)
        ~ return
        }
        
    {task ^ taskPROG_5CYCLES.5of5 || task ^ taskPROG_10CYCLES.10of10 :
        ~ improve_trait(task, taskSTATES)
        {filter(task,taskCOOKER)} has completed {filter(task,taskALL)}.
        ~ recycle(task, taskCOOKER)
        ~ return
        }
        
    {
        - task ^ in_progress && task ^ LIST_ALL(taskCOOKER):
            ~ sorter_improve_progress_TASKDEMO(task)
            {filter(task,taskCOOKER)} is working on {filter(task,taskALL)}.
        - task ^ in_progress:
            {filter(task,taskALL)} has no one assigned to it.
        }
    
    ~ return


// >>>>>>>>>>>>>>>>>> STARTING CYCLE <<<<<<<<<<

=== advanceCYCLE_DEMO
    ~ currentCYCLE ++ // increase counter
    ~ remainingCYCLES = maxCYCLES - currentCYCLE // update remaining cycles
    //~ action_points = max_action_points // refill action points

    ->sorterADVANCE_ALL_TASKDEMO->
    -> newCYCLE_DEMO
  
=== newCYCLE_DEMO

    A NEW CYCLE BEGINS!

    Current Cycle: {currentCYCLE}
    Remaining: {remainingCYCLES}
    {sorter_print_completed_tasks()}
    ->chooseACTION
    
=== chooseACTION

    How will you spend this cycle?

        + START A TASK
            ->taskOptsAvailable
        + {sorter_check_in_progress_TASKDEMO()}STALLED TASKS
            ->taskSTALLED
        + {sorter_check_in_progress_TASKDEMO()}INTERRUPT TASK
            ->taskINTERRUPT
        + CHECK PROGESS BARS
            ->ProgessBars->
            ->chooseACTION
        + NO FURTHER ACTION (END CYCLE)
            ->taskONGOING

// >>>>>>>> INTERUPT PROCESS - TASSKS THAT HAVE MET ALL CONDITIONS TO ADVANCE

=== taskINTERRUPT
    ~ currentTASK = ()
    ~ taskAVAILABLE = ()
    ~ opts_check_2conditions_passto_sorter_TASKDEMO(in_progress,LIST_ALL(taskALL), LIST_ALL(taskCOOKER), taskAVAILABLE)
    {not taskAVAILABLE: No tasks in progress with Cookers.|Reassign Cooker from:}
    <- PopulateOptions(-> taskINTERRUPT_CHOSEN,taskAVAILABLE)
    + Back
        ->chooseACTION
    + Skip
        ->cycle_END_CURRENT
    ->DONE


=== taskINTERRUPT_CHOSEN(x)
    TASK: {x}
    COOKER: {sorter_Xfind_Yoflist_TASKDEMO(x,taskCOOKER)}
    
    Remove cooker from {x}?
    + Yes
        ~ sorter_recycle_delta_TASKDEMO(x,taskCOOKER)
        {sorter_Xfind_Yoflist_TASKDEMO(x,taskCOOKER)}
        ->taskONGOING
    + No/back
    
    --> chooseACTION


// >>>>>>>> REASSIGN PROCESS - TASKS THAT ARE MISSING SOMETHING TO ADVANCE

=== taskSTALLED
    ~ currentTASK = ()
    ~ taskAVAILABLE = ()
    ~ opts_check_1YESconditions_1NOcondition_passto_sorter_TASKDEMO(in_progress,  LIST_ALL(taskCOOKER), LIST_ALL(taskALL),   taskAVAILABLE)
    {not taskAVAILABLE: There are no stalled tasks.|These stalled tasks require Cookers:}
    <- PopulateOptions(-> taskCHOSEN,taskAVAILABLE)
    + Back
        ->chooseACTION
    + Skip
        ->cycle_END_CURRENT
->DONE

// >>>>>>>> NEW TASK ASSIGNMENT

=== taskOptsAvailable
// Start a new task
    ~ currentTASK = ()
    ~ taskAVAILABLE = ()
    ~ opts_check_1conditions_passto_sorter_TASKDEMO(available, LIST_ALL(taskALL), taskAVAILABLE)
    {not taskAVAILABLE: There are no tasks available.|Available Tasks:}
    <- PopulateOptions(-> taskCHOSEN,taskAVAILABLE)
    + Back
        ->chooseACTION
    + Skip
        ->cycle_END_CURRENT

=== taskCHOSEN(x)
    TASK: {x}
    ~ currentTASK += x
    -> taskWHO(x)
    --> DONE

=== taskWHO(x)
    // Assign a cooker to the task.
    {not taskCOOKER: There are no cooks available.|Assign a Cook to {x}}
    <- PopulateOptions(-> taskASSIGNED, taskCOOKER)
    + Skip
        ->cycle_END_CURRENT
        
=== taskASSIGNED(x)
    // Confirm Task and Cook
    ~ currentTASK += x

    TASK: {currentTASK ^ taskALL}
    COOK: {currentTASK ^ taskCOOKER}
    Confirm Assignment?
        + Yes
            ~ sorter_add_delta_TASKDEMO(filter(currentTASK,taskALL),x)
            ~ remove(currentTASK ^ taskCOOKER, taskCOOKER)
            //~ remove(currentTASK ^ taskALL, taskALL)
            ~ taskALL -= chapel
        + No/Change
            ->taskOptsAvailable
    -
    -> chooseACTION
    
// >>>>>>>>>>>>>>>>>> KNOTS TO END CYCLE <<<<<<<<<<

=== taskONGOING
    DEBUG tasks:
    {taskALL}
    {taskCOOKER}
    {build_chapel}
    {do_simple_task} 
    {do_complex_task}
    
    ->cycle_END_CURRENT
    
=== cycle_END_CURRENT
    END CURRENT CYCLE... All counters will advance.
    + Confirm
    -> advanceCYCLE_DEMO


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VAR SORTERS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// Because VARs cannot be passed from a filter function, changing them requires switch statements.
// I call these Switch statements SORTERS as they 'sort' the effect to the correct VAR.
// SORTERs cannot be generalised beyond their structure.
// Therefore all sorters are project specific and kept with the rest of the project files.



=== sorterADVANCE_ALL_TASKDEMO

    ~ advanceTASK(build_chapel)
    ~ advanceTASK(do_simple_task)
    ~ advanceTASK(do_complex_task)

    ->->

=== function sorter_improve_progress_TASKDEMO(ref task)
    {
    -filter(taskPROG_5CYCLES, task):
        ~ improve_trait(task, taskPROG_5CYCLES)
    - filter(taskPROG_10CYCLES,task):
        ~ improve_trait(task, taskPROG_10CYCLES)
    }

=== function sorter_print_completed_tasks()
    {check_overlap(build_chapel,completed): Chapel is completed.}
    {check_overlap(do_simple_task,completed): Simple Task is completed.}
    {check_overlap(do_complex_task,completed): Complex Task is completed.}

=== function sorter_check_in_progress_TASKDEMO()
    {
        - build_chapel ^ in_progress:
            ~ return true
        - in_progress ^ do_simple_task:
            ~ return true
        - in_progress ^ do_complex_task:
            ~ return true
    }


=== function sorter_find_name_TASKDEMO(x)
//returns the task name that X is found in
    {
        - x ^ build_chapel:
            ~ return chapel
        - x ^ do_simple_task:
            ~ return simple_task
        - x ^ do_complex_task:
            ~ return complex_task
    }

=== function sorter_Xfind_Yoflist_TASKDEMO(x, is_what)
// finds the VAR that holds X and returns the needed value from a LIST.
    {
        - x ^ build_chapel:
            ~ return filter(build_chapel, is_what)
        - x ^ do_simple_task:
            ~ return filter(do_simple_task, is_what)
        - x ^ do_complex_task:
            ~ return filter(do_complex_task, is_what)
    }
    
=== function sorter_add_delta_TASKDEMO(x, delta)
// adds the value to the VAR that holds the matching name
    {
        - x ^ build_chapel:
            ~ build_chapel += delta
        - x ^ do_simple_task:
            ~ do_simple_task += delta
        - x ^ do_complex_task:
            ~ do_complex_task += delta
    }

=== function sorter_remove_delta_TASKDEMO(x, delta)
// removes the value to the VAR that holds the matching name
    {
        - x ^ build_chapel:
            ~ build_chapel -= delta
        - x ^ do_simple_task:
            ~ do_simple_task -= delta
        - x ^ do_complex_task:
            ~ do_complex_task -= delta
    }

=== function sorter_recycle_delta_TASKDEMO(ref x, ref delta)
// Runs the RECYCLE function the VAR that holds the matching name
    {
        - x ^ build_chapel:
            ~ recycle(build_chapel,delta)
        - x ^ do_simple_task:
            ~ recycle(do_simple_task,delta)
        - x ^ do_complex_task:
            ~ recycle(do_complex_task,delta)
    }

=== function sorter_pick_delta_TASKDEMO(x, value, ref list)
// Runs the Pick function the VAR that holds the matching x
    {
        - x ^ build_chapel:
            ~ pick(build_chapel,value,list)
        - x ^ do_simple_task:
            ~ pick(do_simple_task,value,list)
        - x ^ do_complex_task:
            ~ pick(do_complex_task,value,list)
    }



// >>>>>>>>>>>>>>>>>> SORT FUNCTIONS TO POPULATE MENUS <<<<<<<<<<

== function opts_check_1condition_passto_sorter_TASKDEMO(condition1,base_list,ref sort_list)
    {not base_list:
        ~ return
    }
    ~ temp value_to_sort = LIST_MIN(base_list)
    ~ opts_check_1condition_addto_VAR_TASKDEMO(condition1, value_to_sort, sort_list)
    ~ opts_check_1condition_passto_sorter_TASKDEMO(condition1,base_list - value_to_sort, sort_list)

=== function opts_check_1condition_addto_VAR_TASKDEMO(condition1,value_to_sort, ref sort_list)
    {
    - check_overlap(build_chapel,condition1) && check_overlap(build_chapel,value_to_sort):
        ~ sort_list += chapel
    - check_overlap(do_simple_task,condition1) && check_overlap(do_simple_task,value_to_sort):
        ~ sort_list += simple_task
    - check_overlap(do_complex_task,condition1) && check_overlap(do_complex_task,value_to_sort):
        ~ sort_list += complex_task
    -else:
        ~ return false
    }

=== function opts_check_1conditions_passto_sorter_TASKDEMO(condition1, base_list, ref sort_list)
    {not base_list:
        ~ return
    }
    ~ temp value_to_sort = LIST_MIN(base_list)
    ~ opts_check_1condition_addto_VAR_TASKDEMO(condition1,value_to_sort, sort_list)
    ~ opts_check_1conditions_passto_sorter_TASKDEMO( condition1, base_list - value_to_sort, sort_list)


== function opts_check_2conditions_passto_sorter_TASKDEMO(condition1,condition2, base_list,ref sort_list)
    {not base_list:
        ~ return
    }
    ~ temp value_to_sort = LIST_MIN(base_list)
    ~ opts_check_2conditions_addto_VAR_TASKDEMO( condition1, condition2,value_to_sort, sort_list)
    ~ opts_check_2conditions_passto_sorter_TASKDEMO( condition1, condition2, base_list - value_to_sort, sort_list)


=== function opts_check_2conditions_addto_VAR_TASKDEMO(condition1, condition2, value_to_sort, ref sort_list)
    {
    - check_overlap(build_chapel,condition1) && check_overlap(build_chapel,condition2) && check_overlap(build_chapel,value_to_sort):
        ~ sort_list += chapel
    - check_overlap(do_simple_task,condition1) && check_overlap(do_simple_task,condition2) && check_overlap(do_simple_task,value_to_sort):
        ~ sort_list += simple_task
    - check_overlap(do_complex_task,condition1) && check_overlap(do_complex_task,condition2) && check_overlap(do_complex_task,value_to_sort):
        ~ sort_list += complex_task
    -else:
        ~ return false
    }

== function opts_check_1YESconditions_1NOcondition_passto_sorter_TASKDEMO(condition1, condition2, base_list,ref sort_list)
    {not base_list:
        ~ return
    }
    ~ temp value_to_sort = LIST_ALL(base_list)
    ~ opts_check_1YESconditions_1NOcondition_addto_VAR_TASKDEMO( condition1,condition2, value_to_sort, sort_list)
    ~ opts_check_1YESconditions_1NOcondition_addto_VAR_TASKDEMO(condition1, condition2, base_list - value_to_sort, sort_list)

=== function opts_check_1YESconditions_1NOcondition_addto_VAR_TASKDEMO(condition1, condition2, base_list, ref sort_list)

    {
        -check_overlap(build_chapel, condition1) && build_chapel !? condition2 && check_overlap(build_chapel, base_list):
            ~ copy(chapel,taskAVAILABLE)
        -check_overlap(do_simple_task, condition1) && not check_overlap(do_simple_task, condition2) && check_overlap(do_simple_task, base_list):
            ~ copy(simple_task,taskAVAILABLE)
        -check_overlap(do_complex_task, condition1) && not check_overlap(do_complex_task, condition2) && check_overlap(do_complex_task, base_list):
            ~ copy(complex_task,taskAVAILABLE)
    }