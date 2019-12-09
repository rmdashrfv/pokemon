let cards = document.getElementsByClassName('pokemon-card')

for (card of cards) {
  card.addEventListener('click', (e) => {
    alert(e.target.closest('div.pokemon-card').id)
  })
}

