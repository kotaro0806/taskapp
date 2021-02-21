//
//  InputViewController.swift
//  TaskApp
//
//  Created by 浅川晃太郎 on 2021/02/07.
//  Copyright © 2021 kotaro.asakawa. All rights reserved.
//

import UIKit
import RealmSwift    // 追加する

class InputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryTextField:UITextField!
    
    let realm = try! Realm()    // 追加する
    var task: Task!   // 追加する
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
            self.view.addGestureRecognizer(tapGesture)

            titleTextField.text = task.title
            contentsTextView.text = task.contents
            datePicker.date = task.date
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.task.category=self.categoryTextField.text!
            self.realm.add(self.task, update: .modified)
        }
        

        super.viewWillDisappear(animated)
    }

        @objc func dismissKeyboard(){
            // キーボードを閉じる
            view.endEditing(true)

        // Do any additional setup after loading the view.
    }

}
