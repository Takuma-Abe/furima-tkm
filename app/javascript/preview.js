window.addEventListener("DOMContentLoaded", () => {
  const itemForm = document.querySelector('.items-sell-main');                        // 商品出品・編集のフォームの取得
  if(!itemForm) return null;                                                          // 取得できなければここで終了 => 新規投稿・編集ページんもみでこのファイルが発火するようにする
  const image_limits = 5;

  // プレビュー画像を生成・表示する
  const buildPreviewImage = (dataIndex, blob) =>{
    const previewWrapper = document.createElement('div');    // プレビュー画像の親要素を生成
    previewWrapper.setAttribute('class', 'preview');
    previewWrapper.setAttribute('data-index', dataIndex);    // プレビュー画像にdata-indexを設定

    const previewImage = document.createElement('img');      // プレビュー画像のimg要素を生成
    previewImage.setAttribute('src', blob);
    previewImage.setAttribute('class', 'preview-image');

    previewWrapper.appendChild(previewImage);    // プレビュー画像の親要素に子要素としてimg要素を追加する
    console.log('プレビューの親要素:', previewWrapper);
    console.log('プレビューのimg要素:', previewImage);

    // 削除ボタンを生成
    const deleteButton = document.createElement("div");
    deleteButton.setAttribute("class", "image-delete-button");
    deleteButton.innerText = "削除";
    previewWrapper.appendChild(deleteButton);                                     // プレビュー画像の親要素に子要素として削除ボタンを追加する
    deleteButton.addEventListener("click", () => deleteImage(dataIndex));

    // プレビュー画像一覧にプレビュー画像を挿入する
    const previewsList = document.querySelector('#previews');
    previewsList.appendChild(previewWrapper);
  }

  const buildNewFileField = () => {
      const newFileField =document.createElement('input');                             //input要素を生成
      newFileField.setAttribute('type', 'file');                                       //生成したinpout要素にtype属性とfileを付与
      newFileField.setAttribute('name', 'item_form[images][]');                             //生成したinput要素にname属性を付与
      
      const lastFileField = document.querySelector('input[type="file"][name="item[images][]"]:last-child') //最後のfile_fieldを取得
    console.log('lastfilefield:',lastFileField);
    const nextDataIndex = Number(lastFileField.getAttribute('data-index')) +1;    // nextDataIndex = 最後のfile_fieldのdata-index + 1
    console.log('next-data-index:', nextDataIndex);
    newFileField.setAttribute('data-index', nextDataIndex);                       // newFileFieldにdaata-index属性を付与

    newFileField.addEventListener("change", changedFileField);

    const fileFieldsArea = document.querySelector('.click-upload');               
    fileFieldsArea.appendChild(newFileField);
  };

  const deleteImage = (dataIndex) => {
    const previewWrapper = document.querySelector(
      `.preview[data-index="${dataIndex}"]`
    );
    previewWrapper.remove();
    const fileField = document.querySelector(
      `input[type="file"][data-index="${dataIndex}"]`
    );
    fileField.remove();
    const image_count = document.querySelectorAll(".preview").length;
    console.log("image_count:", image_count);
    if (image_count == image_limits - 1) buildNewFileField();
  };

  const changedFileField = (e) => {
    console.log("changed:", e.target);
    console.table(e.target.files);
    console.log("1つ目のfile:", e.target.files[0]);

    // data-index（何番目を操作しているか）を取得
    const dataIndex = e.target.getAttribute('data-index');                            // data-index（何番目を操作しているか）を取得
    console.log("data-index:", dataIndex);

    // const previewArea = document.querySelector('.preview');                           // プレビュー該当箇所のdivクラスを取得
    // if(previewArea){                                                                  // 
    //   previewArea.remove();                                                           // 変更する度に中身を削除する記述
    // }


    const file = e.target.files[0];                                                   //イベント発火した箇所のfileを取得
    if (!file) {
      deleteImage(dataIndex);
      return null;
    }

    const blob = window.URL.createObjectURL(file);                                    //取得したfile内にあるURLを生成
    // dataIndexとblobを使ってプレビューを表示させる
    const oldPreviewWrapper = document.querySelector(
      `.preview[data-index="${dataIndex}"]`
    );
    if (oldPreviewWrapper) {
      // 既にプレビューが表示されているので画像の差し替えのみを行い終了する
      const oldPreviewImage = oldPreviewWrapper.querySelector("img");
      oldPreviewImage.setAttribute("src", blob);
      return null;
    }
    buildPreviewImage(dataIndex, blob);  // dataIndexとblobを使ってプレビューを表示させる
    // 新しいfile_fieldを追加する
    const image_count = document.querySelectorAll(".preview").length;
    console.log("image_count:", image_count);
    if (image_count < image_limits)buildNewFileField();
  };
  const fileField = document.querySelector('input[type="file"][name="item[images][]"]');  // 画像のfile_fieldの取得

  fileField.addEventListener("change", changedFileField); //イベント発火
})