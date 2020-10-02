
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
    practice_sequence = [1, 2, 2, 1, 2, 4, 4, 1, 4, 3, 3, 2, 2, 1, 1, 3, 4, 3, 4, 4, 2, 3, 3, 1, 1]
} else {
    sequence = shuffle(sequences)[0]
    practice_sequence = shuffle(sequences)[1]
}



// image arrays
const face_img_arr = ["MA_01.jpg", "MA_02.jpg", "MA_03.jpg", "MA_04.jpg", "MA_05.jpg", "MA_06.jpg", "MA_07.jpg", "MA_08.jpg", "MA_09.jpg", "MA_10.jpg", "MA_11.jpg", "MA_12.jpg", "MC_01.jpg", "MC_02.jpg", "MC_03.jpg", "MC_04.jpg", "MC_05.jpg", "MC_06.jpg", "MC_07.jpg", "MC_08.jpg", "MC_09.jpg", "MC_10.jpg", "MC_11.jpg", "MC_12.jpg", "FA_01.jpg", "FA_02.jpg", "FA_03.jpg", "FA_04.jpg", "FA_05.jpg", "FA_06.jpg", "FA_07.jpg", "FA_08.jpg", "FA_09.jpg", "FA_10.jpg", "FA_11.jpg", "FA_12.jpg", "FC_01.jpg", "FC_02.jpg", "FC_03.jpg", "FC_04.jpg", "FC_05.jpg", "FC_06.jpg", "FC_07.jpg", "FC_08.jpg", "FC_09.jpg", "FC_10.jpg", "FC_11.jpg", "FC_12.jpg"];
const word_img_arr = ["A1_01.png", "A1_02.png", "A1_03.png", "A1_04.png", "A1_05.png", "A1_06.png", "A1_07.png", "A1_08.png", "A1_09.png", "A1_10.png", "A1_11.png", "A1_12.png", "A1_13.png", "A2_01.png", "A2_02.png", "A2_03.png", "A2_04.png", "A2_05.png", "A2_06.png", "A2_07.png", "A2_08.png", "A2_09.png", "A2_10.png", "A2_11.png", "A2_12.png", "A2_13.png", "C1_01.png", "C1_02.png", "C1_03.png", "C1_04.png", "C1_05.png", "C1_06.png", "C1_07.png", "C1_08.png", "C1_09.png", "C1_10.png", "C1_11.png", "C1_12.png", "C1_13.png", "C2_01.png", "C2_02.png", "C2_03.png", "C2_04.png", "C2_05.png", "C2_06.png", "C2_07.png", "C2_08.png", "C2_09.png", "C2_10.png", "C2_11.png", "C2_12.png", "C2_13.png"];
const scene_img_arr = ["I_01.jpg", "I_02.jpg", "I_03.jpg", "I_04.jpg", "I_05.jpg", "I_06.jpg", "I_07.jpg", "I_08.jpg", "I_09.jpg", "I_10.jpg", "I_11.jpg", "I_12.jpg", "I_13.jpg", "I_14.jpg", "I_15.jpg", "I_16.jpg", "I_17.jpg", "I_18.jpg", "I_19.jpg", "I_20.jpg", "I_21.jpg", "I_22.jpg", "I_23.jpg", "I_24.jpg", "I_25.jpg", "O_01.jpg", "O_02.jpg", "O_03.jpg", "O_04.jpg", "O_05.jpg", "O_06.jpg", "O_07.jpg", "O_08.jpg", "O_09.jpg", "O_10.jpg", "O_11.jpg", "O_12.jpg", "O_13.jpg", "O_14.jpg", "O_15.jpg", "O_16.jpg", "O_17.jpg", "O_18.jpg", "O_19.jpg", "O_20.jpg", "O_21.jpg", "O_22.jpg", "O_23.jpg", "O_24.jpg", "O_25.jpg"];
// shuffle images
let face_img_list = shuffle(face_img_arr);
let word_img_list = shuffle(word_img_arr);
let scene_img_list = shuffle(scene_img_arr);

category_labels = ["FACE", "FACE", "WORD", "WORD"]
rule_types = ["gender", "race", "concreteness", "syllables"]
rule_labels_left = ["MALE", "ASIAN", "OBJECT", "1 SYLLABLE"]
rule_labels_right = ["FEMALE", "CAUCASIAN", "NON-OBJECT", "2 SYLLABLES"]
cue_color = ["red", "blue", "green","purple"]

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
        if (image_face.match("A")) {
            LeftRight = "left"
        } else if (image_face.match("C")) {
            LeftRight = "right"
        }
    } else if (seq[i] == 3) {
        if (image_word.match("C")) {
            LeftRight = "left"
        } else if (image_word.match("A")) {
            LeftRight = "right"
        }
    } else if (seq[i] == 4) {
        if (image_word.match("1_")) {
            LeftRight = "left"
        } else if (image_word.match("2_")) {
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
for (i = 0; i < sequence.length; i++) {

    imgs = select_images(sequence,face_img_list, word_img_list, scene_img_list)

    ts_trials.push(new Data_row({
        time_end: "incomplete",
        practice: false,
        memory: false,
        trial: i,
        trialtype: sequence[i],
        category: category_labels[sequence[i] - 1],
        rule: rule_types[sequence[i] - 1],
        rule_labels_left: rule_labels_left[sequence[i] - 1],
        rule_labels_right: rule_labels_right[sequence[i] - 1],
        cue_color: cue_color[sequence[i] - 1],
        answer: imgs.LeftRight,
        image_face: imgs.image_face,
        image_word: imgs.image_word,
        image_scene: imgs.image_scene
    }))

}



let test_sequence = [],
    temp = ["old_word", "old_scene", "new_word", "new_scene"]
// loop through the list to create 4*24=96 trials
for (i = 0; i < sequence.length-1; i++) {
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
        trial_img = "words/"+word_img_list[old_word_ind];
        OldNew = "old";
        old_word_ind++
    } else if (test_sequence[i] == "old_scene") {
        target_word = "NA";
        target_scene = scene_img_list[old_scene_ind];
        lure_word = "NA";
        lure_scene = "NA";
        trial_img = "scenes/"+scene_img_list[old_scene_ind];
        OldNew = "old";
        old_scene_ind++
    } else if (test_sequence[i] == "new_word") {
        target_word = "NA";
        target_scene = "NA";
        lure_word = word_img_list[new_word_ind + sequence.length];
        lure_scene = "NA";
        trial_img = "words/"+word_img_list[new_word_ind + sequence.length];
        OldNew = "new";
        new_word_ind++
    } else if (test_sequence[i] == "new_scene") {
        target_word = "NA";
        target_scene = "NA";
        lure_word = "NA";
        lure_scene = scene_img_list[new_scene_ind + sequence.length];
        trial_img = "scenes/"+scene_img_list[new_scene_ind + sequence.length];
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
const practice_face_img_arr = ["MA_01.jpg", "MA_02.jpg", "MA_03.jpg", "MA_04.jpg", "MA_05.jpg", "MA_06.jpg", "MA_07.jpg", "MA_08.jpg", "MA_09.jpg", "MA_10.jpg", "MA_11.jpg", "MA_12.jpg", "MC_01.jpg", "MC_02.jpg", "MC_03.jpg", "MC_04.jpg", "MC_05.jpg", "MC_06.jpg", "MC_07.jpg", "MC_08.jpg", "MC_09.jpg", "MC_10.jpg", "MC_11.jpg", "MC_12.jpg", "FA_01.jpg", "FA_02.jpg", "FA_03.jpg", "FA_04.jpg", "FA_05.jpg", "FA_06.jpg", "FA_07.jpg", "FA_08.jpg", "FA_09.jpg", "FA_10.jpg", "FA_11.jpg", "FA_12.jpg", "FC_01.jpg", "FC_02.jpg", "FC_03.jpg", "FC_04.jpg", "FC_05.jpg", "FC_06.jpg", "FC_07.jpg", "FC_08.jpg", "FC_09.jpg", "FC_10.jpg", "FC_11.jpg", "FC_12.jpg"];
const practice_word_img_arr = ["A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png","A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png","A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png","A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png","A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png","A1_p.png", "A2_p.png", "C1_p.png", "C2_p.png"];
const practice_scene_img_arr = ["I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg","I_p.jpg", "O_p.jpg"];
// randomize the image order to make a image list for the current subject
let practice_face_img_list = shuffle(practice_face_img_arr);
let practice_word_img_list = shuffle(practice_word_img_arr);
let practice_scene_img_list = shuffle(practice_scene_img_arr);

for (i = 0; i < 24; i++) {

    imgs = select_images(practice_sequence, practice_face_img_list, practice_word_img_list, practice_scene_img_list)

    practice.push(new Data_row({
        time_end: "incomplete",
        practice: true,
        memory: false,
        trial: i,
        trialtype: practice_sequence[i],
        category: category_labels[practice_sequence[i] - 1],
        rule: rule_types[practice_sequence[i] - 1],
        rule_labels_left: rule_labels_left[practice_sequence[i] - 1],
        rule_labels_right: rule_labels_right[practice_sequence[i] - 1],
        cue_color: cue_color[practice_sequence[i] - 1],
        answer: imgs.LeftRight,
        image_face: imgs.image_face,
        image_word: imgs.image_word,
        image_scene: imgs.image_scene
    }))

}

let trials = practice.concat(ts_trials);

