/***

task-switching w/ shapes & multiple tasks

***/
// fallback to vanilla timers if eventTimer is not loaded...
if (typeof eventTimer == 'undefined') {
    //console.log("no eventTimer found... using JS setTimeout/Interval")
    var eventTimer = {};
    eventTimer.setTimeout = function (fun, time) {
        window.setTimeout(fun, time)
    }
    eventTimer.setInterval = function (fun, time) {
        window.setInterval(fun, time)
    }
}


const ts_memory = function () {

    const init = function () {
        // show load screen
        load_screen();

        eventTimer.cancelAllRequests();

        get_info.set_current_task("ts_memory")


        // create content display within the main-display div
        document.querySelector("#main-display").style.display = "flex"
        document.querySelector("#main-display").innerHTML = `
                        <div class="content-display flex flex-column justify-center f6 lh-copy" style="text-align: left">
                        </div>`
        ts_memory.instructions_pg1();
        //
    }

    // triggers loading screen
    const load_screen = function () {
        document.querySelector("#main-display").innerHTML = `<div>Loading images...</div><div class="load loader"></div>`

    }


    ////////// INSTRUCTIONS //////////////
    const instructions_pg1 = function () {
        document.querySelector(".content-display").style.visibility = "hidden"


        document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div>
                            <p>This is <strong> PART 3 </strong> of the experiment. There is no practice for this part. It is going to be a surprise memory test for the stimuli that were shown to you in <strong> PART 1 </strong>, including the words and scenes. Faces will not be tested.</p>
                            <div class="standard-display absolute-center">
                                    <img src="images/instructions_3.png" style="width: 300px"></img>
                            </div>
                            <p>On each trial you will be presented with an image. Please indicate whether you have seen it before in <strong> PART 1 </strong> (old or new), as well as your confidence (definitely or probably). There is no time limit for this task, you can take as long as you want on each trial. Please be as accurate as possible, and if unsure, please make the best guess. You will be given the results of your memory accuracy at the end of the experiment. </p>
                            <br>
                            <p>Also, it may be helpful to note that half of the stimuli will be old and half of them will be new. </p>
                            <div class="flex flex-row">
                            <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">NEXT</a>
                        </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_memory.instructions_pg2();")
        document.querySelector(".content-display").style.visibility = "visible"
    }

    const instructions_pg2 = function () {
        eventTimer.cancelAllRequests()
        let content = document.querySelector(".content-display")
        content.style.visibility = "hidden"

        content.innerHTML =
            `<h3>Instructions</h3>
            <div>
                <p>That's it! This is the end of the instructions for <strong> PART 3 </strong>. Please use the "previous" and "next" buttons if you'd like to review the instructions</p>
                <p>When you are ready to begin, press START. The memory task will begin immediately after pressing START.</p>
            </div>

                <div class="flex flex-row" style="">
                    <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                    <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">START</a>
                </div>
            </div>
            `
        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_memory.instructions_pg1();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_memory.start_exp();")

        content.style.visibility = "visible"
    }


    /////////// EXPERIMENT /////////////////

    let trial_counter = -1,
        time1,
        time2,
        timer,
        total_acc = 0


    const start_exp = function () {
        document.querySelector("#main-display").innerHTML = `<div class="standard-display absolute-center">/div>`

        show_target();
    }


    const show_target = function () {

        // increase our trial counter
        trial_counter++

        if (trial_counter >= mem_trials.length) {
            score = 100 * total_acc / 96;
            document.querySelector("#main-display").innerHTML =
            `<div>
                <p style="font-size: 72px">You scored `+ score.toFixed(2) + `%</p>
            </div>
            <div class="flex flex-row" style="">
                <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">NEXT</a>
            </div>`
            document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: master.next();")

            return;
        }

        time1 = window.performance.now();

        document.querySelector("#main-display").style.visibility = "hidden"
        document.querySelector("#main-display").innerHTML =
            `<div class="content-display">
                <div>
                    <p style="font-size: 20px">Please rate whether you've seen the following scene/word in PART 1. </p>
                    <p style="font-size: 14px">Scenes/words shown in PART 1 are considered old, otherwise they are new. There is no time limit for this task, so please feel free to take your time to think back whether or not you have seen this scene/word.</p>
                <div class="standard-display absolute-center" >
                    <img src="images/MainExpStimuli/` + mem_trials[trial_counter].trial_img + `" style="width: 400px; opacity: 0.5"></img>
                </div>
                </div>
                <div class="standard-display absolute-center" id = "memory_rating_test">
                    <br>
                    <input type = "radio" name = "memory rating" value = "1">Definitely New</input>
                    <input type = "radio" name = "memory rating" value = "2">Probably New</input>
                    <input type = "radio" name = "memory rating" value = "3">Probably Old</input>
                    <input type = "radio" name = "memory rating" value = "4">Definitely Old</input>
                    <br>
                </div>
                <div class="flex flex-row standard-display absolute-center" style="">
                    <br>
                    <a id="dyn-bttn" class="bttn f6 link dim ph3 pv2 mb2 dib white bg-gray" href="#0">NEXT</a>
                </div>
            </div>`

        document.querySelector("#main-display").style.visibility = "visible"

        // record memory rating response. currently supports changing answer; response finalized upon clicking "next" button.
        let memory_rating = document.getElementsByName("memory rating");
        memory_rating_test.addEventListener('click', function () {
            for (i = 0; i < memory_rating.length; i++) {

                if (memory_rating[i].checked) {
                    time2 = window.performance.now();
                    mem_trials[trial_counter].response_time = time2 - time1; // record RT
                    mem_trials[trial_counter].response = memory_rating[i].value; // record response
                    if (mem_trials[trial_counter].answer == "new" && mem_trials[trial_counter].response < 3) {
                        mem_trials[trial_counter].response_acc = 1
                        total_acc++
                    } else if (mem_trials[trial_counter].answer == "old" && mem_trials[trial_counter].response >= 3) {
                        mem_trials[trial_counter].response_acc = 1;
                        total_acc++
                    } else mem_trials[trial_counter].response_acc = 0;

                    document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_memory.show_target();")
                }
            }
        })

    }


    return {
        init: init,
        load_screen: load_screen,
        instructions_pg1: instructions_pg1,
        instructions_pg2: instructions_pg2,
        start_exp: start_exp,
        show_target: show_target,
        mem_trials: mem_trials
    }
}();
