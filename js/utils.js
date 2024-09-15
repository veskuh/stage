.pragma library

function canCopy(item) {
    console.log(item + " " + item.selectedText)
    return item && item.selectedText!==undefined && item.selectedText !== ""
}
