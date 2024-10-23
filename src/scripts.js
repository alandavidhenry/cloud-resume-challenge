functionApiUrl = 'https://func-cloud-resume-challenge.azurewebsites.net/api/http_trigger?code=L8R-9rLbvZlVZEOdon9ZMTbc9iv1f8v7qblsVwOy1HbNAzFuf6cE6g%3D%3D'

async function getCount() {
  try {
    const response = await fetch(functionApiUrl, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache'
      },
      cache: 'no-store' 
    })
    const data = await response.json()
    return data.count
  } catch (error) {
      console.error('Error fetching count:', error)
      throw error
  }
}

async function updateCount(newCount) {
  try {
    await fetch(functionApiUrl, {
      method: "POST",
      headers: { 
        "Content-Type": "application/json",
        'Cache-Control': 'no-cache'
      },
      body: JSON.stringify({ count: newCount }),
    })
  } catch (error) {
      console.error('Error updating count', error)
      throw error
  }
}

async function updateVisitorCount() {
  try {
    let count = await getCount()
    count++
    await updateCount(count)
    document.querySelector(".count").textContent = count
  } catch (error) {
      console.error('Error in updateVisitorCount:', error)
      throw error
  }
}

updateVisitorCount()
