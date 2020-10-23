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

// preload images & run instructions_pg1 when complete
preLoad.addImages(["images/MainExpStimuli/faces/M_C_001.jpg", "images/MainExpStimuli/faces/M_C_002.jpg", "images/MainExpStimuli/faces/M_C_003.jpg", "images/MainExpStimuli/faces/M_C_004.jpg", "images/MainExpStimuli/faces/M_C_005.jpg", "images/MainExpStimuli/faces/M_C_006.jpg", "images/MainExpStimuli/faces/M_C_007.jpg", "images/MainExpStimuli/faces/M_C_008.jpg", "images/MainExpStimuli/faces/M_C_009.jpg", "images/MainExpStimuli/faces/M_C_010.jpg", "images/MainExpStimuli/faces/M_C_011.jpg", "images/MainExpStimuli/faces/M_C_012.jpg", "images/MainExpStimuli/faces/M_C_013.jpg", "images/MainExpStimuli/faces/M_C_014.jpg", "images/MainExpStimuli/faces/M_C_015.jpg", "images/MainExpStimuli/faces/M_C_016.jpg", "images/MainExpStimuli/faces/M_C_017.jpg", "images/MainExpStimuli/faces/M_C_018.jpg", "images/MainExpStimuli/faces/M_C_019.jpg", "images/MainExpStimuli/faces/M_C_020.jpg", "images/MainExpStimuli/faces/M_C_021.jpg", "images/MainExpStimuli/faces/M_C_022.jpg", "images/MainExpStimuli/faces/M_C_023.jpg", "images/MainExpStimuli/faces/M_C_024.jpg", "images/MainExpStimuli/faces/M_C_025.jpg", "images/MainExpStimuli/faces/F_C_001.jpg", "images/MainExpStimuli/faces/F_C_002.jpg", "images/MainExpStimuli/faces/F_C_003.jpg", "images/MainExpStimuli/faces/F_C_004.jpg", "images/MainExpStimuli/faces/F_C_005.jpg", "images/MainExpStimuli/faces/F_C_006.jpg", "images/MainExpStimuli/faces/F_C_007.jpg", "images/MainExpStimuli/faces/F_C_008.jpg", "images/MainExpStimuli/faces/F_C_009.jpg", "images/MainExpStimuli/faces/F_C_010.jpg", "images/MainExpStimuli/faces/F_C_011.jpg", "images/MainExpStimuli/faces/F_C_012.jpg", "images/MainExpStimuli/faces/F_C_013.jpg", "images/MainExpStimuli/faces/F_C_014.jpg", "images/MainExpStimuli/faces/F_C_015.jpg", "images/MainExpStimuli/faces/F_C_016.jpg", "images/MainExpStimuli/faces/F_C_017.jpg", "images/MainExpStimuli/faces/F_C_018.jpg", "images/MainExpStimuli/faces/F_C_019.jpg", "images/MainExpStimuli/faces/F_C_020.jpg", "images/MainExpStimuli/faces/F_C_021.jpg", "images/MainExpStimuli/faces/F_C_022.jpg", "images/MainExpStimuli/faces/F_C_023.jpg", "images/MainExpStimuli/faces/F_C_024.jpg", "images/MainExpStimuli/faces/F_C_025.jpg", "images/MainExpStimuli/words/U_01.png", "images/MainExpStimuli/words/U_02.png", "images/MainExpStimuli/words/U_03.png", "images/MainExpStimuli/words/U_04.png", "images/MainExpStimuli/words/U_05.png", "images/MainExpStimuli/words/U_06.png", "images/MainExpStimuli/words/U_07.png", "images/MainExpStimuli/words/U_08.png", "images/MainExpStimuli/words/U_09.png", "images/MainExpStimuli/words/U_10.png", "images/MainExpStimuli/words/U_11.png", "images/MainExpStimuli/words/U_12.png", "images/MainExpStimuli/words/U_13.png", "images/MainExpStimuli/words/U_14.png", "images/MainExpStimuli/words/U_15.png", "images/MainExpStimuli/words/U_16.png", "images/MainExpStimuli/words/U_17.png", "images/MainExpStimuli/words/U_18.png", "images/MainExpStimuli/words/U_19.png", "images/MainExpStimuli/words/U_20.png", "images/MainExpStimuli/words/U_21.png", "images/MainExpStimuli/words/U_22.png", "images/MainExpStimuli/words/U_23.png", "images/MainExpStimuli/words/U_24.png", "images/MainExpStimuli/words/U_25.png", "images/MainExpStimuli/words/L_01.png", "images/MainExpStimuli/words/L_02.png", "images/MainExpStimuli/words/L_03.png", "images/MainExpStimuli/words/L_04.png", "images/MainExpStimuli/words/L_05.png", "images/MainExpStimuli/words/L_06.png", "images/MainExpStimuli/words/L_07.png", "images/MainExpStimuli/words/L_08.png", "images/MainExpStimuli/words/L_09.png", "images/MainExpStimuli/words/L_10.png", "images/MainExpStimuli/words/L_11.png", "images/MainExpStimuli/words/L_12.png", "images/MainExpStimuli/words/L_13.png", "images/MainExpStimuli/words/L_14.png", "images/MainExpStimuli/words/L_15.png", "images/MainExpStimuli/words/L_16.png", "images/MainExpStimuli/words/L_17.png", "images/MainExpStimuli/words/L_18.png", "images/MainExpStimuli/words/L_19.png", "images/MainExpStimuli/words/L_20.png", "images/MainExpStimuli/words/L_21.png", "images/MainExpStimuli/words/L_22.png", "images/MainExpStimuli/words/L_23.png", "images/MainExpStimuli/words/L_24.png", "images/MainExpStimuli/words/L_25.png", "images/MainExpStimuli/scenes/I_01.jpg", "images/MainExpStimuli/scenes/I_02.jpg", "images/MainExpStimuli/scenes/I_03.jpg", "images/MainExpStimuli/scenes/I_04.jpg", "images/MainExpStimuli/scenes/I_05.jpg", "images/MainExpStimuli/scenes/I_06.jpg", "images/MainExpStimuli/scenes/I_07.jpg", "images/MainExpStimuli/scenes/I_08.jpg", "images/MainExpStimuli/scenes/I_09.jpg", "images/MainExpStimuli/scenes/I_10.jpg", "images/MainExpStimuli/scenes/I_11.jpg", "images/MainExpStimuli/scenes/I_12.jpg", "images/MainExpStimuli/scenes/I_13.jpg", "images/MainExpStimuli/scenes/I_14.jpg", "images/MainExpStimuli/scenes/I_15.jpg", "images/MainExpStimuli/scenes/I_16.jpg", "images/MainExpStimuli/scenes/I_17.jpg", "images/MainExpStimuli/scenes/I_18.jpg", "images/MainExpStimuli/scenes/I_19.jpg", "images/MainExpStimuli/scenes/I_20.jpg", "images/MainExpStimuli/scenes/I_21.jpg", "images/MainExpStimuli/scenes/I_22.jpg", "images/MainExpStimuli/scenes/I_23.jpg", "images/MainExpStimuli/scenes/I_24.jpg", "images/MainExpStimuli/scenes/I_25.jpg", "images/MainExpStimuli/scenes/O_01.jpg", "images/MainExpStimuli/scenes/O_02.jpg", "images/MainExpStimuli/scenes/O_03.jpg", "images/MainExpStimuli/scenes/O_04.jpg", "images/MainExpStimuli/scenes/O_05.jpg", "images/MainExpStimuli/scenes/O_06.jpg", "images/MainExpStimuli/scenes/O_07.jpg", "images/MainExpStimuli/scenes/O_08.jpg", "images/MainExpStimuli/scenes/O_09.jpg", "images/MainExpStimuli/scenes/O_10.jpg", "images/MainExpStimuli/scenes/O_11.jpg", "images/MainExpStimuli/scenes/O_12.jpg", "images/MainExpStimuli/scenes/O_13.jpg", "images/MainExpStimuli/scenes/O_14.jpg", "images/MainExpStimuli/scenes/O_15.jpg", "images/MainExpStimuli/scenes/O_16.jpg", "images/MainExpStimuli/scenes/O_17.jpg", "images/MainExpStimuli/scenes/O_18.jpg", "images/MainExpStimuli/scenes/O_19.jpg", "images/MainExpStimuli/scenes/O_20.jpg", "images/MainExpStimuli/scenes/O_21.jpg", "images/MainExpStimuli/scenes/O_22.jpg", "images/MainExpStimuli/scenes/O_23.jpg", "images/MainExpStimuli/scenes/O_24.jpg", "images/MainExpStimuli/scenes/O_25.jpg"])


const ts_attn = function () {

    const init = function () {
        // show load screen
        load_screen();
        preLoad.set.onComplete(ts_attn.instructions_pg1)

        eventTimer.cancelAllRequests();

        get_info.set_current_task("ts_attn")


        // create content display within the main-display div
        document.querySelector("#main-display").style.display = "flex"
        document.querySelector("#main-display").innerHTML = `
                        <div class="content-display flex flex-column justify-center f6 lh-copy" style="text-align: left">
                        </div>`

        //

        preLoad.loadImages()
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
                            <p>In this experiment, there will be 3 parts. There will be instructions at the beginning of each part. </p>
                            <br>
                            <p style="color:red; font-size:24px;"> You must score above (75%) in the first two parts of the experiment and above (60%) in the third part of the experiment for the HIT to be approved. Failure to perform above this criteria in any part of the experiment may result in the HIT being rejected. </p>
                            <div class="flex flex-row">
                            <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">NEXT</a>
                            </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.instructions_pg2();")
        document.querySelector(".content-display").style.visibility = "visible"
    }

    const instructions_pg2 = function () {
        document.querySelector(".content-display").style.visibility = "hidden"


        document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div>
                            <p> In <strong> PART 1 </strong>, you will be making judgements on faces and words. You will be given one of the four possible cues (shown below) on every trial, which will instruct you on what type of judgement to make. For example, you might be asked to answer "is the face male?", or "is the word uppercase?" </p>
                            <p> You will be using the “Z” and “M” buttons on the keyboard to indicate your response (“Z” is YES and "M" is NO). You only need to respond to the cued category. </p>
                            <div class="standard-display absolute-center">
                                    <img src="images/instructions_1.png" style="width: 600px"></img>
                            </div>
                            <div class="flex flex-row" style="">
                                <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                                <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">NEXT</a>
                            </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_attn.instructions_pg1();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.instructions_pg3();")

        document.querySelector(".content-display").style.visibility = "visible"
    }

    const instructions_pg3 = function () {
        document.querySelector(".content-display").style.visibility = "hidden"


        document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div>
                            <p>Before each trial you will be presented a cue informing you the target dimension for the upcoming display. </p>
                            <p>On each trial you will be presented with a face, an object, and a scene. Your task will be to focus on the cued category and make the correct dimensional judgment. </p>
                             <div class="standard-display absolute-center">
                                    <img src="images/instructions_2.png" style="width: 500px"></img>
                            </div>
                            <p>Here are examples of two trials. On the first trial, you are cued to pay attention to the word and judge whether it is lowercase. The correct answer is YES, so you will need to press “Z”. On the second trial, you are cued to pay attention to the face and judge whether it is male. The correct answer is NO, so you will need to press “M”. Each display will be on the screen for 3 seconds (fixed duration), and you will need to respond within that time. </p>
                            <p style="color:red; font-size:20px;"> Please pay close attention to the stimuli shown in <strong>PART 1</strong>, because you will later be tested for your memory for these stimuli in <strong>PART 3</strong>. The amount of bonus you will get will depend on your memory.</p>
                            <div class="flex flex-row" style="">
                                <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                                <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">NEXT</a>
                            </div>
                        </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_attn.instructions_pg2();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.instructions_pg4();")

        document.querySelector(".content-display").style.visibility = "visible"
    }


    const instructions_pg4 = function () {
        eventTimer.cancelAllRequests()
        let content = document.querySelector(".content-display")
        content.style.visibility = "hidden"

        content.innerHTML =
            `<h3>Instructions</h3>
            <div>
                <p>That's it! This is the end of the instructions for <strong> PART 1 </strong>. Please use the "previous" and "next" buttons if you'd like to review the instructions</p>
				<p>Before we begin the experimental trials, you will first have to complete 4 practice trials. You must get all of the practice trials correct, before you can move on to the experimental trials. If you do not get all of them correct, you will have to redo the practice trials.</p>
                <p>When you are ready to begin the practice trials, press START. The sequence will begin immediately after pressing START.</p>
                <p style="color:red; font-size:20px;"> REMEMBER: Please pay close attention to the stimuli shown in <strong>PART 1</strong>, because you will later be tested for your memory for these stimuli in <strong>PART 3</strong>. The amount of bonus you will get will depend on your memory.</p>
            </div>
                <div class="flex flex-row" style="">
                    <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                    <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">START</a>
                </div>
            </div>
            `
        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_attn.instructions_pg3();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.start_exp();")

        content.style.visibility = "visible"
    }


    /////////// EXPERIMENT /////////////////

    let trial_counter = -1,
        allow_keys = false,
        time1,
        time2,
        timer,
        responded,
        allow_sp = false,
        practice_acc = 0,
        mainexp_acc = 0,
        nPractice = 4

    const start_exp = function () {
        document.addEventListener("keydown", keydown, false)
        document.querySelector("#main-display").innerHTML = `<div class="standard-display absolute-center">/div>`

        fixate_0();
    }



    const fixate_0 = function () {
        allow_keys = false
        allow_sp = false


        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
                <p style="font-size: 72px">+</p>
            </div>`
        timer = eventTimer.setTimeout(show_cue, 750)
    }


    const show_cue = function () {
        // increase our trial counter
        trial_counter++

        if (trial_counter >= trials.length) {
            score = (100 * mainexp_acc / 100)
                document.querySelector("#main-display").innerHTML =
                `<div class="standard-display absolute-center">
                    <p style="font-size: 72px">Your accuracy is `+ score.toFixed(2) + `%</p>
                </div>
                <div class="flex flex-row" style="">
                <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">NEXT</a>
                </div>`
            document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: master.next();")
            return;
        }

        // replace HTML in main-display
        document.querySelector("#main-display").style.visibility = "hidden"
        document.querySelector("#main-display").innerHTML =
            `<div id=cue cclass="standard-display absolute-center"">
                <div style="width:100%; text-align: center">` +
            `<p style="font-size: 72px">` + trials[trial_counter].rule + `?</p>
                </div>
            </div>
        `

        document.querySelector("#main-display").style.visibility = "visible"
        document.getElementById("cue").style.color = trials[trial_counter].cue_color
        timer = eventTimer.setTimeout(fixate_1, 500)
    }

    const fixate_1 = function () {
        allow_keys = false
        allow_sp = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
                <p style="font-size: 72px">+</p>
            </div>`
        timer = eventTimer.setTimeout(show_target, 500)
    }


    const show_target = function () {
        time1 = window.performance.now();
        allow_keys = true

        document.querySelector("#main-display").style.visibility = "hidden"
        document.querySelector("#main-display").innerHTML =
            `<div class="img-overlay-container">
                <img class="face-img-overlay" src="images/MainExpStimuli/faces/` + trials[trial_counter].image_face + `"</img>
                <img class="word-img-overlay" src="images/MainExpStimuli/words/` + trials[trial_counter].image_word + `"</img>
                <img class="scene-img-overlay" src="images/MainExpStimuli/scenes/` + trials[trial_counter].image_scene + `"</img>
            </div>`

        document.querySelector("#main-display").style.visibility = "visible"

        timer = eventTimer.setTimeout(target_timeout, 3000)
    }


    const target_timeout = function () {
        allow_sp = true
        allow_keys = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
            <div>
            <p style="font-size: 36px">Too slow!</p> <br>
            <p style="font-size: 36px">Press the spacebar to continue</p>
            </div>
        </div>
        `
        trials[trial_counter].response = "none"
        trials[trial_counter].response_time = 0
        trials[trial_counter].response_acc = trials[trial_counter].response == trials[trial_counter].answer
    }


    const feedback = function () {
        allow_keys = false
        allow_sp = false

        if (trial_counter == nPractice - 1) {
            document.querySelector("#main-display").innerHTML =
                `<div class="standard-display absolute-center">
                    <p style="font-size: 36px"></p>
                </div>
                `
            timer = eventTimer.setTimeout(end_practice, 750)
            return;
        }

        if (ts_attn.trials[trial_counter].answer == ts_attn.trials[trial_counter].response) {
            document.querySelector("#main-display").innerHTML =
                `<div class="standard-display absolute-center">
                    <p style="font-size: 36px">correct</p>
                </div>
                `

            timer = eventTimer.setTimeout(end_trial, 750)

        } else {

            allow_sp = true
            allow_keys = false

            document.querySelector("#main-display").innerHTML =
                `<div class="standard-display absolute-center">
            <div>
            <p style="font-size: 36px">incorrect</p> <br>
            <p style="font-size: 36px">press the spacebar to continue</p>
            </div>
            </div>
            `
        }
    }


    const end_trial = function () {
        allow_keys = false
        allow_sp = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
            <p style="font-size: 72px">+</p>
        </div>
        `
        timer = eventTimer.setTimeout(show_cue, 1000)
    }


    const end_practice = function () {
        eventTimer.cancelAllRequests()

        if (practice_acc >= 4) {
            // create content display within the main-display div
            document.querySelector("#main-display").style.display = "flex"
            document.querySelector("#main-display").innerHTML = `
                        <div class="content-display flex flex-column justify-center f6 lh-copy" style="text-align: left">
                        </div>`

            document.querySelector(".content-display").style.visibility = "hidden"


            document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div><p>Great! You've completed the practice trials</p>
                            <p>The experimental trials will be exactly the same as the practice trials. Try to respond as quickly and as accurately as possible</p>
                            <p>When you are ready to begin the experimental trials, press start.</p>
                            <div class="flex flex-row">
                            <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">START MAIN EXPERIMENT</a>
                        </div>
                        </div>
                        `

            document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.fixate_0();")
            document.querySelector(".content-display").style.visibility = "visible"

        } else {

            redo_practice();
        }

    }


    const redo_practice = function () {
        trial_counter = -1
        practice_acc = 0

        // create content display within the main-display div
        document.querySelector("#main-display").style.display = "flex"
        document.querySelector("#main-display").innerHTML = `
                        <div class="content-display flex flex-column justify-center f6 lh-copy" style="text-align: left">
                        </div>`

        document.querySelector(".content-display").style.visibility = "hidden"
        document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div><p>You did not get 100% correct on the practice trials. Before moving forward, you must get all practice trials correct</p>
                            <p>Reminder: On each trial you will be presented with a face, an object, and a scene. Your task will be to focus on the cued category and make the correct judgment. </p>
                            <p> You will respond as quickly and as accurately as possible using the keyboard. You will press "Z" for YES or "M" for NO. Press start to redo the practice trials.</p>
                            <div class="flex flex-row">
                            <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">START PRACTICE</a>
                        </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_attn.fixate_0();")
        document.querySelector(".content-display").style.visibility = "visible"
    }

    /// on keydown event // added as event listener on init
    let keydown = function (event) {
        console.log(event.keyCode)
        // log key time
        time2 = window.performance.now();
        let key = event.keyCode ? event.keyCode : event.which;

        // prevent backspace from exiting page (maybe?)
        if (event.keyCode == 8) {
            event.preventDefault();
            return;
        }

        if (allow_sp == true) {
            if (key == 32) {
                fixate_0();
                return
            }
        }

        // do nothing if allow_keys is false
        if (allow_keys == false) {
            return;
        }

        if (key == 77 | key == 90) {
            eventTimer.cancelRequest(timer)

            responded = true;
            allow_keys = false;

            trials[trial_counter].response = (key == 90) ? "left" : "right";
            trials[trial_counter].response_time = time2 - time1
            trials[trial_counter].response_acc = trials[trial_counter].response == trials[trial_counter].answer

            if (trials[trial_counter].response == trials[trial_counter].answer) {
                practice_acc++
                if (trial_counter > nPractice) {
                    mainexp_acc++
                }
            }
            timer = eventTimer.setTimeout(feedback, 2000 - trials[trial_counter].response_time)
        }
    };


    return {
        init: init,
        load_screen: load_screen,
        instructions_pg1: instructions_pg1,
        instructions_pg2: instructions_pg2,
        instructions_pg3: instructions_pg3,
        instructions_pg4: instructions_pg4,
        start_exp: start_exp,
        show_cue: show_cue,
        fixate_0: fixate_0,
        fixate_1: fixate_1,
        show_target: show_target,
        target_timeout: target_timeout,
        end_trial: end_trial,
        trials: trials
    }
}();
