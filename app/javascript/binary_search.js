function binary_search() {
  const numberForm = document.getElementById('number-form')
  numberForm.addEventListener('submit', (e) => {
    e.preventDefault()
    const formData = new FormData(numberForm);
    // Ajax通信を飛ばす
    const XHR = new XMLHttpRequest 
    XHR.open('POST', '/binaries/binary-search', true)
    XHR.responseType = "json"
    XHR.send(formData)
    XHR.onload = () => {
      // 通信に失敗した時
      console.log(XHR.response)
      if (XHR.status != 200) {
       alert(`Error ${XHR.status}: ${XHR.statusText}`);
       return null;
     } 
     const deletedNumbers = XHR.response.deleted_numbers 
     const target = XHR.response.target 
     const index = XHR.response.index 
    //  検索対象が見つからなかった場合
     if ( index === 0 ) {
       alert(`Error お探しの数字は見つかりませんでした`);
       return null;
     }   
    //  検索対象から除外された数字たちに透明になるstyleを付与
     deletedNumbers.forEach(deletedNumber => {
       const deleteNumber = document.getElementById(deletedNumber)
      //  次回検索時に検索対象から外すためhidden_filedからname属性を削除する。
       const deleteInput = document.getElementById(`input_${deletedNumber}`)
       deleteNumber.setAttribute('class', 'deleted');
       deleteInput.removeAttribute('name')
     })
    //  検索対象が見つかった時
     if (deletedNumbers.length == 1 || index === 1)   {
       const targetNumber = document.getElementById(target)
       const deleteTargetInput = document.getElementById(`input_${target}`)
       targetNumber.setAttribute('class', 'target' )
       alert(`Success! お探しの数字が見つかりました!`);
      //  検索対象が見つかった場合hidden_fieldは残すようにすることで次回検索時に検索に失敗しない。(このifブロックが再度実行される)
     }
    }
  })

}

window.addEventListener("load", binary_search);