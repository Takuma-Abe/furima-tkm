window.addEventListener("DOMContentLoaded", () => {
  const itemForm = document.querySelector('.items-sell-main');                        // 商品出品・編集のフォームの取得
  if(!itemForm) return null;                                                          // 取得できなければここで終了 => 新規投稿・編集ページんもみでこのファイルが発火するようにする
  const fileField = document.querySelector('input[type="file"][name="item[image]"]')  // 画像のfile_fieldの取得

  fileField.addEventListener("change", (e)=> {                                        // イベント発火

    const previewArea = document.querySelector('.preview');                           // プレビュー該当箇所のdivクラスを取得
    if(previewArea){                                                                  // 
      previewArea.remove();                                                           // 変更する度に中身を削除する記述
    }

    const file = e.target.files[0];                                                   //イベント発火した箇所のfileを取得
    const blob = window.URL.createObjectURL(file);                                    //取得したfile内にあるURLを生成

    const previewWrapper = document.createElement('div');                             // プレビュー画像を見せるためdiv要素の生成
    previewWrapper.setAttribute('class', 'preview');                                  // クラス属性付与

    const previewImage = document.createElement('img');                               // プレビュー画像を見せるためimg要素の生成
    previewImage.setAttribute('src', blob)                                            // src属性・変数blobのurlを付与
    previewImage.setAttribute('class', 'preview-image')                               // クラス属性付与

    previewWrapper.appendChild(previewImage);                                         // 生成したdiv要素内にimgを子要素として追加する

    const previewList = document.querySelector('#previews');                          
    previewList.appendChild(previewWrapper);
  });
});