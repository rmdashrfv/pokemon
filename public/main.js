/* 
*  load the file via AJAX, might run into CORS though
*
*/
let newPokemonForm = document.getElementById('new-pokemon')
let slot = document.getElementById('slot')
let loadButton = document.getElementById('load-btn')

loadButton.addEventListener('click', (e) => {
  loadGame()
})

let loadGame = async () => {
  let req = await fetch('./gamedata/blaziken_19009bae0c05ccc26c16b1e0.json')
  let res = await req.json()
  // populate the slot div with relevant data
console.log(res)
  slot.innerHTML = `
    <h3>${res.name} Lv. ${res.level}</h3>
    <h4>${res.exp} EXP.</h4>
  `
}

newPokemonForm.addEventListener('submit', (e) => {
  (async () => {
    e.preventDefault()
    let name = document.getElementById('pokemon-name').value
    let form = new FormData()
    form.append('pokemon_name', name) 
    let req = await fetch('/pokemon', {method: 'POST', body: form})
    let res = await req.json()
    console.log(res)
  })()  
})




