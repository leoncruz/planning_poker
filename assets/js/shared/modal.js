document.addEventListener('DOMContentLoaded', () => {
  function openModal(element) {
    element.classList.add('is-active')
  }

  function closeModal(element) {
    element.classList.remove('is-active')
  }

  function closeAllModals() {
    (document.querySelectorAll('.modal') || []).forEach(($modal) => {
      closeModal($modal);
    });
  }

  (document.querySelectorAll('.open-modal') || []).forEach((element) => {
    element.addEventListener('click', () => {
      const target = document.getElementById(element.dataset.target); 

      openModal(target);
    });
  });

  (document.querySelectorAll('.close-modal') || []).forEach((element) => {
    const target = element.closest('.modal');

    element.addEventListener('click', () => {
      closeModal(target);
    })
  });

  document.addEventListener('keydown', (event) => {
    const e = event || window.event;

    if (e.keyCode === 27) { // Escape key
      closeAllModals();
    }
  });
})
