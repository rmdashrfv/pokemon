/* 
*  load the file via AJAX, might run into CORS though
*
*/

let loadButton = document.getElementById('load-btn')

loadButton.addEventListener('click', (e) => {
  loadGame()
})

let loadGame = async () => {
  let req = await fetch('./blaziken.json')
  let res = await req.json()
  // populate the slot div with relevant data
  console.log(res)
}
