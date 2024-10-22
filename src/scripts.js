let visitCount = localStorage.getItem('pageViews')  || 0
visitCount++
localStorage.setItem('pageViews', visitCount)
document.querySelector('.count').textContent = visitCount