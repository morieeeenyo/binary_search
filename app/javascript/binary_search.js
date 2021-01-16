function binary_search() {
  const numberForm = document.getElementById('number-form')
  numberForm.addEventListener('submit', (e) => {
    e.preventDefault()
    const formData = new FormData(numberForm);
    const XHR = new XMLHttpRequest 
    XHR.open('POST', '/binaries/binary-search', true)
    XHR.responseType = "json"
    XHR.send(formData)
    XHR.onload = () => {
      console.log(XHR.response)
      if (XHR.status != 200) {
       alert(`Error ${XHR.status}: ${XHR.statusText}`);
       return null;
     } 
     const deletedNumbers = XHR.response.deleted_numbers 
     const target = XHR.response.target 
     const index = XHR.response.index 
     if ( index === 0 ) {
       alert(`Error お探しの数字は見つかりませんでした`);
       return null;
     }   
     deletedNumbers.forEach(deletedNumber => {
       const deleteNumber = document.getElementById(deletedNumber)
       const deleteInput = document.getElementById(`input_${deletedNumber}`)
       deleteNumber.setAttribute('class', 'deleted');
       deleteInput.removeAttribute('name')
     })
     if (deletedNumbers.length == 1 || index === 1)   {
       const targetNumber = document.getElementById(target)
       const deleteTargetInput = document.getElementById(`input_${target}`)
       targetNumber.setAttribute('class', 'target' )
      //  deleteTargetInput.removeAttribute('name')
       alert(`Success! お探しの数字が見つかりました!`);
     }
    }
  })

}

window.addEventListener("load", binary_search);