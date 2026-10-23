/**
 * AFRICAN CULINARY TREASURES: INTERACTIVE APPLICATION
 * Powers portion scaling, live ingredient search, tab filtering,
 * interactive step timers, and modal controllers.
 */

document.addEventListener('DOMContentLoaded', () => {
  initTabs();
  initSearch();
  initPortionCalculators();
  initCheckboxes();
  initTimers();
  initModals();
  initPrint();
});

/* -----------------------------------------------------------------------------
   1. TAB FILTERING
   ----------------------------------------------------------------------------- */
function initTabs() {
  const tabs = document.querySelectorAll('.tab-btn');
  const cards = document.querySelectorAll('.recipe-card');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');

      const filter = tab.dataset.filter;
      cards.forEach(card => {
        if (filter === 'all' || card.dataset.dish === filter) {
          card.style.display = 'block';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });
}

/* -----------------------------------------------------------------------------
   2. INSTANT SEARCH
   ----------------------------------------------------------------------------- */
function initSearch() {
  const searchInput = document.getElementById('recipe-search');
  const cards = document.querySelectorAll('.recipe-card');

  if (!searchInput) return;

  searchInput.addEventListener('input', (e) => {
    const term = e.target.value.toLowerCase().trim();

    cards.forEach(card => {
      const text = card.textContent.toLowerCase();
      const meta = (card.dataset.ingredients || '').toLowerCase();

      if (term === '' || text.includes(term) || meta.includes(term)) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  });
}

/* -----------------------------------------------------------------------------
   3. DYNAMIC PORTION CALCULATOR
   Scales ingredient quantities dynamically based on portion +/- buttons
   ----------------------------------------------------------------------------- */
function initPortionCalculators() {
  const plusBtns = document.querySelectorAll('.serv-btn.plus');
  const minusBtns = document.querySelectorAll('.serv-btn.minus');

  plusBtns.forEach(btn => {
    btn.addEventListener('click', () => updateServings(btn.dataset.target, 1));
  });

  minusBtns.forEach(btn => {
    btn.addEventListener('click', () => updateServings(btn.dataset.target, -1));
  });
}

function updateServings(dish, delta) {
  const countEl = document.getElementById(`serv-count-${dish}`);
  if (!countEl) return;

  const baseServings = parseFloat(countEl.dataset.base) || 6;
  let currentServings = parseInt(countEl.textContent, 10) || baseServings;
  let newServings = currentServings + delta;

  // Enforce limits (2 to 30 servings)
  if (newServings < 2) newServings = 2;
  if (newServings > 30) newServings = 30;

  countEl.textContent = newServings;

  const multiplier = newServings / baseServings;
  const listEl = document.getElementById(`ing-list-${dish}`);
  if (!listEl) return;

  const qtyElements = listEl.querySelectorAll('.qty');
  qtyElements.forEach(qty => {
    const baseVal = parseFloat(qty.dataset.base);
    if (!isNaN(baseVal)) {
      let scaled = baseVal * multiplier;
      // Round nicely
      if (scaled >= 10) {
        qty.textContent = Math.round(scaled);
      } else {
        qty.textContent = parseFloat(scaled.toFixed(1));
      }
    }
  });
}

/* -----------------------------------------------------------------------------
   4. INTERACTIVE CHECKBOXES
   ----------------------------------------------------------------------------- */
function initCheckboxes() {
  const checkboxes = document.querySelectorAll('.ingredient-list input[type="checkbox"]');
  checkboxes.forEach(cb => {
    cb.addEventListener('change', (e) => {
      const li = e.target.closest('li');
      if (e.target.checked) {
        li.classList.add('checked');
      } else {
        li.classList.remove('checked');
      }
    });
  });
}

/* -----------------------------------------------------------------------------
   5. INTERACTIVE STEP TIMERS (Web Audio Synthesizer Chime)
   ----------------------------------------------------------------------------- */
let timerInterval = null;
let remainingSeconds = 0;
let isPaused = false;

function initTimers() {
  const timerBtns = document.querySelectorAll('.timer-btn');
  const modal = document.getElementById('timer-modal');
  const display = document.getElementById('timer-display');
  const toggleBtn = document.getElementById('timer-toggle');
  const resetBtn = document.getElementById('timer-reset');
  const closeBtn = document.getElementById('timer-close');

  timerBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const seconds = parseInt(btn.dataset.time, 10);
      const title = btn.textContent.replace('⏱', '').trim();
      startTimer(seconds, title);
    });
  });

  if (toggleBtn) {
    toggleBtn.addEventListener('click', () => {
      if (isPaused) {
        isPaused = false;
        toggleBtn.textContent = 'Pause';
      } else {
        isPaused = true;
        toggleBtn.textContent = 'Resume';
      }
    });
  }

  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      stopTimer();
      modal.style.display = 'none';
    });
  }

  if (closeBtn) {
    closeBtn.addEventListener('click', () => {
      stopTimer();
      modal.style.display = 'none';
    });
  }
}

function startTimer(seconds, title) {
  const modal = document.getElementById('timer-modal');
  const titleEl = document.getElementById('timer-title');
  const toggleBtn = document.getElementById('timer-toggle');

  stopTimer();
  remainingSeconds = seconds;
  isPaused = false;

  if (titleEl) titleEl.textContent = title;
  if (toggleBtn) toggleBtn.textContent = 'Pause';
  if (modal) modal.style.display = 'block';

  renderTimerDisplay();

  timerInterval = setInterval(() => {
    if (!isPaused) {
      remainingSeconds--;
      renderTimerDisplay();

      if (remainingSeconds <= 0) {
        stopTimer();
        playChime();
        alert(`🔔 Timer Complete: ${title}!`);
      }
    }
  }, 1000);
}

function stopTimer() {
  if (timerInterval) {
    clearInterval(timerInterval);
    timerInterval = null;
  }
}

function renderTimerDisplay() {
  const display = document.getElementById('timer-display');
  if (!display) return;

  const mins = Math.floor(remainingSeconds / 60);
  const secs = remainingSeconds % 60;
  display.textContent = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
}

// Synthetic chime using Web Audio API (zero external assets needed)
function playChime() {
  try {
    const AudioContext = window.AudioContext || window.webkitAudioContext;
    if (!AudioContext) return;
    const ctx = new AudioContext();
    
    const osc = ctx.createOscillator();
    const gain = ctx.createGain();

    osc.type = 'sine';
    osc.frequency.setValueAtTime(587.33, ctx.currentTime); // D5
    osc.frequency.setValueAtTime(880, ctx.currentTime + 0.15); // A5

    gain.gain.setValueAtTime(0.3, ctx.currentTime);
    gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.8);

    osc.connect(gain);
    gain.connect(ctx.destination);

    osc.start();
    osc.stop(ctx.currentTime + 0.8);
  } catch (e) {
    console.log('Audio cue unavailable:', e);
  }
}

/* -----------------------------------------------------------------------------
   6. MODAL SYSTEM
   ----------------------------------------------------------------------------- */
function initModals() {
  const gitBtn = document.getElementById('git-cheat-btn');
  const gitModal = document.getElementById('git-modal');
  const closeBtn = document.getElementById('modal-close');

  if (gitBtn && gitModal) {
    gitBtn.addEventListener('click', () => gitModal.classList.add('active'));
  }

  if (closeBtn && gitModal) {
    closeBtn.addEventListener('click', () => gitModal.classList.remove('active'));
  }

  window.addEventListener('click', (e) => {
    if (e.target === gitModal) {
      gitModal.classList.remove('active');
    }
  });
}

/* -----------------------------------------------------------------------------
   7. PRINT ACTION
   ----------------------------------------------------------------------------- */
function initPrint() {
  const printBtn = document.getElementById('print-book-btn');
  if (printBtn) {
    printBtn.addEventListener('click', () => window.print());
  }
}
