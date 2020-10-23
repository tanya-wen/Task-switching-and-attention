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


const ts_flanker = function () {

    const init = function () {
        // show load screen
        load_screen();

        eventTimer.cancelAllRequests();

        get_info.set_current_task("ts_flanker")


        // create content display within the main-display div
        document.querySelector("#main-display").style.display = "flex"
        document.querySelector("#main-display").innerHTML = `
                        <div class="content-display flex flex-column justify-center f6 lh-copy" style="text-align: left">
                        </div>`
        ts_flanker.instructions_pg1();

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
                            <p>Wlecome to <strong> PART 2 </strong>. On each trial you will be presented with 5 arrows. Your task is to judge whether the middle arrow is pointing to the left or right.</p>
                            <p>Sometimes the middle arrow is pointing in the same direction as the other arrows. And sometimes the middle arrow is pointing in a different direction from the other arrows. But you only need to pay attention to the middle arrow and ignore the other arrows</p>

                            <div class="standard-display absolute-center">
                                    <img src="images/right_incongruent.png" style="width: 300px"></img>
                            </div>
                            <p> You will respond as quickly and as accurately as possible using the keyboard. You will press "Z" for left or "M" for right.</p>
                            <div class="flex flex-row">
                            <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">NEXT</a>
                        </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_flanker.instructions_pg2();")
        document.querySelector(".content-display").style.visibility = "visible"
    }

    const instructions_pg2 = function () {
        document.querySelector(".content-display").style.visibility = "hidden"


        document.querySelector(".content-display").innerHTML = `
                        <h3> Instructions </h3>
                        <div>
                            <p>In this example below, you would press "Z" (left):</p>
                             <div class="standard-display absolute-center">
                                    <img src="images/left_congruent.png" style="width: 300px"></img>
                            </div>
                            <p>And in this example below, you would press "M" (right):</p>
                            <div class="standard-display absolute-center">
                                   <img src="images/right_incongruent.png" style="width: 300px"></img>
                           </div>
                           <p>You won't get feedback on each individual trial, but you will recieve an overall accuracy score at the end of this part. Please try to score as high as possible!</p>
                            
                            <div class="flex flex-row" style="">
                                <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                                <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">NEXT</a>
                            </div>
                        </div>
                        </div>
                        `

        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_flanker.instructions_pg1();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_flanker.instructions_pg3();")

        document.querySelector(".content-display").style.visibility = "visible"
    }


    const instructions_pg3 = function () {
        eventTimer.cancelAllRequests()
        let content = document.querySelector(".content-display")
        content.style.visibility = "hidden"

        content.innerHTML =
            `<h3>Instructions</h3>
            <div>
                <p>That's it! This is the end of the instructions for <strong> PART 2 </strong>. Please use the "previous" and "next" buttons if you'd like to review the instructions</p>
                <p>When you are ready to begin, press START. The memory task will begin immediately after pressing START.</p>
			</div>

                <div class="flex flex-row" style="">
                    <a id="dyn-bttn-2" class="bttn b-left f6 link dim ph3 pv2 mb2 dib white bg-dark-gray" href="#0">PREVIOUS</a>
                    <a id="dyn-bttn" class="bttn b-right f6 link dim ph3 pv2 mb2 dib white bg-green" href="#0">START</a>
                </div>
            </div>
            `
        document.querySelector("#dyn-bttn-2").setAttribute("onClick", "javascript: ts_flanker.instructions_pg2();")
        document.querySelector("#dyn-bttn").setAttribute("onClick", "javascript: ts_flanker.start_exp();")

        content.style.visibility = "visible"
    }


    /////////// EXPERIMENT /////////////////

    let trial_counter = -1,
        allow_keys = false,
        time1,
        time2,
        timer,
        responded,
        total_acc = 0

    const start_exp = function () {
        document.addEventListener("keydown", keydown, false)
        document.querySelector("#main-display").innerHTML = `<div class="standard-display absolute-center">/div>`

        fixate_0();
    }



    const fixate_0 = function () {
        allow_keys = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
                <p style="font-size: 36px">+</p>
            </div>`
        timer = eventTimer.setTimeout(show_target, 1000)
    }


    const show_target = function () {

        // increase our trial counter
        trial_counter++

        if (trial_counter >= f_trials.length) {
            score = 100 * total_acc / f_trials.length;
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
        allow_keys = true

        document.querySelector("#main-display").style.visibility = "hidden"
        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
                <img src="images/` + f_trials[trial_counter].flanker_img + `" style="width: 500px"></img>
            </div>`

        document.querySelector("#main-display").style.visibility = "visible"

        timer_timeout = eventTimer.setTimeout(target_timeout, 1000)

    }

    const target_timeout = function () {
        allow_keys = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
            <div>
            <p style="font-size: 36px">+</p> <br>
            </div>
        </div>
        `
        f_trials[trial_counter].response = "none"
        f_trials[trial_counter].response_time = 0
        f_trials[trial_counter].response_acc = f_trials[trial_counter].response == f_trials[trial_counter].answer

        ts_flanker.end_trial();
    }

    const end_trial = function () {
        allow_keys = false

        document.querySelector("#main-display").innerHTML =
            `<div class="standard-display absolute-center">
            <p style="font-size: 36px">+</p>
        </div>
        `
        if (f_trials[trial_counter].response_time === 0) {
            timer = eventTimer.setTimeout(show_target, 500)
        } else {
            timer = eventTimer.setTimeout(show_target, 1000 - f_trials[trial_counter].response_time)
        }
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

        // do nothing if allow_keys is false
        if (allow_keys == false) {
            return;
        }

        if (key == 77 | key == 90) {
            eventTimer.cancelRequest(timer_timeout)
            clearTimeout(timer_timeout)

            responded = true;
            allow_keys = false;

            f_trials[trial_counter].response = (key == 90) ? "left" : "right";
            f_trials[trial_counter].response_time = time2 - time1
            f_trials[trial_counter].response_acc = f_trials[trial_counter].response == f_trials[trial_counter].answer

            if (f_trials[trial_counter].response == f_trials[trial_counter].answer) {
                total_acc++
            }
            ts_flanker.end_trial();
        }

    };





    const create_trials = function () {

        let f_sequence = [],
            temp = [1, 2, 3, 4]
        // loop through the list to create 24 trials
        for (i = 0; i < 6; i++) {
            temp = shuffle(temp);
            f_sequence.push(temp[0], temp[1], temp[2], temp[3]);
        }


        labels = ["left_congruent", "right_congruent", "left_incongruent", "right_incongruent"]

        let f_trials = [],
            LeftRight

        for (i = 0; i < f_sequence.length; i++) {

            if (labels[f_sequence[i] - 1].match("left")) {
                LeftRight = "left"
            } else {
                LeftRight = "right"
            }

            f_trials.push(new Data_row({
                time_end: "incomplete",
                flanker: true,
                trial: i,
                trialtype: labels[f_sequence[i] - 1],
                answer: LeftRight,
                flanker_img: labels[f_sequence[i] - 1].concat(".png")
            }))

        }
        return f_trials
    }


    let f_trials = create_trials();

    return {
        init: init,
        load_screen: load_screen,
        instructions_pg1: instructions_pg1,
        instructions_pg2: instructions_pg2,
        instructions_pg3: instructions_pg3,
        start_exp: start_exp,
        fixate_0: fixate_0,
        show_target: show_target,
        end_trial: end_trial,
        f_trials: f_trials
    }
}();
