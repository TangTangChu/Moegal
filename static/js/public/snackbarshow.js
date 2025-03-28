import {snackbar} from '/static/js/public/mdui.esm.js';

function snackbarshow(text){
    snackbar({'message':text,'closeOnOutsideClick':true,'autoCloseDelay':8000});
}

export{snackbarshow};
