/* 
*  load the file via AJAX, might run into CORS though
*
*/

let slot = document.getElementById('slot')
let loadButton = document.getElementById('load-btn')

loadButton.addEventListener('click', (e) => {
  loadGame()
})

let loadGame = async () => {
  let req = await fetch('./gamedata/blaziken.json')
  let res = await req.json()
  // populate the slot div with relevant data
console.log(res)
  slot.innerHTML = `
    <h3>${res.name} Lv. ${res.level}</h3>
    <h4>${res.exp} EXP.</h4>
  `
}
