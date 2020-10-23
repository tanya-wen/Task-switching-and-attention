
/* shuffle an array */
function shuffle(array) {
    var tmp, current, top = array.length;
    if (top)
        while (--top) {
            current = Math.floor(Math.random() * (top + 1));
            tmp = array[current];
            array[current] = array[top];
            array[top] = tmp;
        }

    return array;
}


let sequence,
    practice_sequence
if (typeof sequences === 'undefined') {
    // if the variable is undefined
    sequence = [1, 1, 3, 3, 4, 2, 3, 4, 1, 1, 2, 1, 2, 2, 4, 4, 3, 3, 1, 4, 4, 3, 2, 2, 1]
    practice_sequence = [1, 2, 3, 4]
} else {
    sequence = shuffle(sequences)[0]
    practice_sequence = shuffle([1, 2, 3, 4])
}



// image arrays
const face_img_arr = ["M_C_001.jpg", "M_C_002.jpg", "M_C_003.jpg", "M_C_004.jpg", "M_C_005.jpg", "M_C_006.jpg", "M_C_007.jpg", "M_C_008.jpg", "M_C_009.jpg", "M_C_010.jpg", "M_C_011.jpg", "M_C_012.jpg", "M_C_013.jpg", "M_C_014.jpg", "M_C_015.jpg", "M_C_016.jpg", "M_C_017.jpg", "M_C_018.jpg", "M_C_019.jpg", "M_C_020.jpg", "M_C_021.jpg", "M_C_022.jpg", "M_C_023.jpg", "M_C_024.jpg", "M_C_025.jpg", "F_C_001.jpg", "F_C_002.jpg", "F_C_003.jpg", "F_C_004.jpg", "F_C_005.jpg", "F_C_006.jpg", "F_C_007.jpg", "F_C_008.jpg", "F_C_009.jpg", "F_C_010.jpg", "F_C_011.jpg", "F_C_012.jpg", "F_C_013.jpg", "F_C_014.jpg", "F_C_015.jpg", "F_C_016.jpg", "F_C_017.jpg", "F_C_018.jpg", "F_C_019.jpg", "F_C_020.jpg", "F_C_021.jpg", "F_C_022.jpg", "F_C_023.jpg", "F_C_024.jpg", "F_C_025.jpg"];
const word_img_arr = ["U_01.png", "U_02.png", "U_03.png", "U_04.png", "U_05.png", "U_06.png", "U_07.png", "U_08.png", "U_09.png", "U_10.png", "U_11.png", "U_12.png", "U_13.png", "U_14.png", "U_15.png", "U_16.png", "U_17.png", "U_18.png", "U_19.png", "U_20.png", "U_21.png", "U_22.png", "U_23.png", "U_24.png", "U_25.png", "L_01.png", "L_02.png", "L_03.png", "L_04.png", "L_05.png", "L_06.png", "L_07.png", "L_08.png", "L_09.png", "L_10.png", "L_11.png", "L_12.png", "L_13.png", "L_14.png", "L_15.png", "L_16.png", "L_17.png", "L_18.png", "L_19.png", "L_20.png", "L_21.png", "L_22.png", "L_23.png", "L_24.png", "L_25.png"];
const scene_img_arr = ["I_01.jpg", "I_02.jpg", "I_03.jpg", "I_04.jpg", "I_05.jpg", "I_06.jpg", "I_07.jpg", "I_08.jpg", "I_09.jpg", "I_10.jpg", "I_11.jpg", "I_12.jpg", "I_13.jpg", "I_14.jpg", "I_15.jpg", "I_16.jpg", "I_17.jpg", "I_18.jpg", "I_19.jpg", "I_20.jpg", "I_21.jpg", "I_22.jpg", "I_23.jpg", "I_24.jpg", "I_25.jpg", "O_01.jpg", "O_02.jpg", "O_03.jpg", "O_04.jpg", "O_05.jpg", "O_06.jpg", "O_07.jpg", "O_08.jpg", "O_09.jpg", "O_10.jpg", "O_11.jpg", "O_12.jpg", "O_13.jpg", "O_14.jpg", "O_15.jpg", "O_16.jpg", "O_17.jpg", "O_18.jpg", "O_19.jpg", "O_20.jpg", "O_21.jpg", "O_22.jpg", "O_23.jpg", "O_24.jpg", "O_25.jpg"];
// shuffle images
let face_img_list = shuffle(face_img_arr);
let word_img_list = shuffle(word_img_arr);
let scene_img_list = shuffle(scene_img_arr);

category_labels = ["FACE", "FACE", "WORD", "WORD"]
rule_types = ["male", "female", "uppercase", "lowercase"]
rule_labels_left = "YES"
rule_labels_right = "NO"
cue_color = ["blue", "red", "green", "purple"]

let ts_trials = [];

function select_images(seq_order, face_list, word_list, scene_list) {

    const seq = seq_order;
    const image_face = face_list[i];
    const image_word = word_list[i];
    const image_scene = scene_list[i];
    let LeftRight;

    if (seq[i] == 1) {
        if (image_face.match("M")) {
            LeftRight = "left"
        } else if (image_face.match("F")) {
            LeftRight = "right"
        }
    } else if (seq[i] == 2) {
        if (image_face.match("F")) {
            LeftRight = "left"
        } else if (image_face.match("M")) {
            LeftRight = "right"
        }
    } else if (seq[i] == 3) {
        if (image_word.match("U")) {
            LeftRight = "left"
        } else if (image_word.match("L")) {
            LeftRight = "right"
        }
    } else if (seq[i] == 4) {
        if (image_word.match("L")) {
            LeftRight = "left"
        } else if (image_word.match("U")) {
            LeftRight = "right"
        }
    }

    return ({
        image_face: image_face,
        image_word: image_word,
        image_scene: image_scene,
        LeftRight: LeftRight
    })
}



// pick images for the task switching exp
for (var repeat = 0; repeat < 4; repeat++) {
    
    for (var i = 0; i < sequence.length; i++) {

        imgs = select_images(sequence, face_img_list, word_img_list, scene_img_list)

        ts_trials.push(new Data_row({
            time_end: "incomplete",
            practice: false,
            memory: false,
            trial: i,
            trialtype: sequence[i],
            category: category_labels[sequence[i] - 1],
            rule: rule_types[sequence[i] - 1],
            cue_color: cue_color[sequence[i] - 1],
            answer: imgs.LeftRight,
            image_face: imgs.image_face,
            image_word: imgs.image_word,
            image_scene: imgs.image_scene
        }))
    }
}



let test_sequence = [],
    temp = ["old_word", "old_scene", "new_word", "new_scene"]
// loop through the list to create 4*24=96 trials
for (i = 0; i < sequence.length - 1; i++) {
    temp = shuffle(temp);
    test_sequence.push(temp[0], temp[1], temp[2], temp[3]);
}
// pick images for the memory exp
let mem_trials = [],
    old_word_ind = 1,
    old_scene_ind = 1,
    new_word_ind = 0,
    new_scene_ind = 0
for (i = 0; i < (test_sequence.length); i++) {

    if (test_sequence[i] == "old_word") {
        target_word = word_img_list[old_word_ind];
        target_scene = "NA";
        lure_word = "NA";
        lure_scene = "NA";
        trial_img = "words/" + word_img_list[old_word_ind];
        OldNew = "old";
        old_word_ind++
    } else if (test_sequence[i] == "old_scene") {
        target_word = "NA";
        target_scene = scene_img_list[old_scene_ind];
        lure_word = "NA";
        lure_scene = "NA";
        trial_img = "scenes/" + scene_img_list[old_scene_ind];
        OldNew = "old";
        old_scene_ind++
    } else if (test_sequence[i] == "new_word") {
        target_word = "NA";
        target_scene = "NA";
        lure_word = word_img_list[new_word_ind + sequence.length];
        lure_scene = "NA";
        trial_img = "words/" + word_img_list[new_word_ind + sequence.length];
        OldNew = "new";
        new_word_ind++
    } else if (test_sequence[i] == "new_scene") {
        target_word = "NA";
        target_scene = "NA";
        lure_word = "NA";
        lure_scene = scene_img_list[new_scene_ind + sequence.length];
        trial_img = "scenes/" + scene_img_list[new_scene_ind + sequence.length];
        OldNew = "new";
        new_scene_ind++
    }

    mem_trials.push(new Data_row({
        time_end: "incomplete",
        memory: true,
        trial: i,
        category: test_sequence[i],
        answer: OldNew,
        target_word: target_word,
        target_scene: target_scene,
        lure_word: lure_word,
        lure_scene: lure_scene,
        trial_img: trial_img
    }))

}



let practice = [];
// shuffle images 
const practice_face_img_arr = ["M_C_001.jpg", "M_C_002.jpg", "M_C_003.jpg", "M_C_004.jpg", "M_C_005.jpg", "M_C_006.jpg", "M_C_007.jpg", "M_C_008.jpg", "M_C_009.jpg", "M_C_010.jpg", "M_C_011.jpg", "M_C_012.jpg", "M_C_013.jpg", "M_C_014.jpg", "M_C_015.jpg", "M_C_016.jpg", "M_C_017.jpg", "M_C_018.jpg", "M_C_019.jpg", "M_C_020.jpg", "M_C_021.jpg", "M_C_022.jpg", "M_C_023.jpg", "M_C_024.jpg", "M_C_025.jpg", "F_C_001.jpg", "F_C_002.jpg", "F_C_003.jpg", "F_C_004.jpg", "F_C_005.jpg", "F_C_006.jpg", "F_C_007.jpg", "F_C_008.jpg", "F_C_009.jpg", "F_C_010.jpg", "F_C_011.jpg", "F_C_012.jpg", "F_C_013.jpg", "F_C_014.jpg", "F_C_015.jpg", "F_C_016.jpg", "F_C_017.jpg", "F_C_018.jpg", "F_C_019.jpg", "F_C_020.jpg", "F_C_021.jpg", "F_C_022.jpg", "F_C_023.jpg", "F_C_024.jpg", "F_C_025.jpg"];
const practice_word_img_arr = ["U_p.png", "L_p.png", "U_p.png", "L_p.png"];
const practice_scene_img_arr = ["I_p.jpg", "O_p.jpg", "I_p.jpg", "O_p.jpg"];
// randomize the image order to make a image list for the current subject
let practice_face_img_list = shuffle(practice_face_img_arr);
let practice_word_img_list = shuffle(practice_word_img_arr);
let practice_scene_img_list = shuffle(practice_scene_img_arr);

for (i = 0; i < 4; i++) {

    imgs = select_images(practice_sequence, practice_face_img_list, practice_word_img_list, practice_scene_img_list)

    practice.push(new Data_row({
        time_end: "incomplete",
        practice: true,
        memory: false,
        trial: i,
        trialtype: practice_sequence[i],
        category: category_labels[practice_sequence[i] - 1],
        rule: rule_types[practice_sequence[i] - 1],
        cue_color: cue_color[practice_sequence[i] - 1],
        answer: imgs.LeftRight,
        image_face: imgs.image_face,
        image_word: imgs.image_word,
        image_scene: imgs.image_scene
    }))

}

let trials = practice.concat(ts_trials);

