let cards = document.getElementsByClassName('pokemon-card')

for (card of cards) {
  card.addEventListener('click', (e) => {
     window.location.href = `/pokemon/${e.target.closest('div.pokemon-card').id}`
  })
}

