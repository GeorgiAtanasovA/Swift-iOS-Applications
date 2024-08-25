//  ViewController.swift
//  Learn Language

//  Created by Georgi on 8.11.20.
//  Copyright © 2020 Georgi. All rights reserved.

import UIKit
import Network
import AVFoundation

class ViewController: UIViewController, UIWindowSceneDelegate, UITextViewDelegate, AVSpeechSynthesizerDelegate, URLSessionDelegate, UIFontPickerViewControllerDelegate
{
   var timer_ShowStartText = Timer()
   var timer_SlidingInputTextView = Timer()
   var timer_ShowHideAlphabetLetters = Timer()
   var timer_showHide_AllLessonsText = Timer()
   var timer_seeTranslationAnimateClock = Timer()
   var timer_MiddleIconReturnCorrectPos = Timer()
   //Thread.sleep(forTimeInterval: 5)
   
   var getRandomIndex = 0
   var voiceChoice_Int = -1
   var lastSentenceSumPos = 0
   var index_sentencePos = -1
   var count_learnedWords = 0
   var index_ShowStartTxt = 0
   var index_animatedClock = 1
   var index_ShowABCletters = 0
   var guessedLettersCount = 0
   var sentenceLength_Level = 1
   var count_nweWorldsToLearn = 0
   var theSum_ofAllConnectedSentences = 0
   var reachTheNumberOfGuessedLetters = 10
   var velocity = 0.0
   var viewMaxX = 0.0
   var distSlide = 0.5
   var posX_object = 0.0
   var posY_object = 0.0
   var width_object = 0.0
   var posX_objMove = 0.0
   var height_object = 0.0
	var keyboardHight = 0.0
   var index_textSize = 22.0
   var speedSpeak_index = 0.4
   let dist_halfScreen = 150.0
   var gestureDirection_X = 0.0
   var btnThatMoves_PrevPosX = 0.0
   var isMenuShow = false
	var isKeyboardOn = false
   var isSavedWords = false
   var leftDirection = false
   var rightDirection = false
   var isAllLessonText = false
   var isLeftSlideBegan = true
   var isRightSlideBegan = true
   var setTextTo_ITV_One = false
   var isNoPrev_NextText = false
   var isSomeWord_Pressed = false
   var isSpeak_savedWords = false
   var isSeeTranslBtn_pressed = false
   var isPlayAplhabet_Pressed = false
   var isITV_OneX_notInScreen = false
   var alphabetShowHide_isShow = false
   var isITV_One_becomeFirstRes = false
   var spokenL = ""
   var fontName = ""
   var alphabetL = ""
   var savedColor = ""
   var imageNumber = "4️⃣"
   var isRepeatedWord = ""
   var lessonFileName = ""
   var someTouchedWord = "!!!"
   var googleTransURL_Str = ""
   var learnedLessonMarker = ""
   var learnedLessonSymbol = "✔️"    //⭐️
   var words_forLearning_Str = ""
   var selectedLanguage_Str  = ""
   var lesson_forLearning_Str = ""
   var sentenceOrWord_translatedText = ""
   var lastOpenedFile_str = "_LastOpenedFile]"
   var sentenceOrWord_AfterShowingAllText = ""
   var alphabetLetters_StringArr = [String]()
   var lessonSentencesAndWords_Arr = [String]()    // Основния масив. В него се зарежда текста разделен на изречения
   var sentencesConnectedParts_fromTheLesson_Arr = [String]() // Масив в който се зареждат свързани изречения в зависимост от "sentencesLength"
   var theSum_ofConnectedSentences_Arr = [Int]()
   let speakerSynthesizer = AVSpeechSynthesizer()
   var alphabetBtns_Arr = [UIButton]()
   var saveSettings_Dictionary = UserDefaults.standard
   var count_LearnedWords_Dictionary = UserDefaults.standard
   var fontColor_Alert = UIAlertController()
   var returnOrNextLesson = UIAlertController()
   var NETmonitor = NWPathMonitor()
   var fontColor: UIColor = UIColor.label
   var returnToStartOfTheLesson = UIAlertController()
   
   @IBOutlet var menu_Btn: UIButton!
   @IBOutlet var speaker_Btn: UIButton!
   @IBOutlet var clearTxt_Btn: UIButton!
   @IBOutlet var hideKeyboard_Btn: UIButton!
   @IBOutlet var iKnowThisWord_btn: UIButton!
   @IBOutlet var guessTheLetter_Btn: UIButton!
   @IBOutlet var chooseLanguage_Btn: UIButton!
   @IBOutlet var seeTranslation_Btn: UIButton!
   @IBOutlet var sentencesLength_Btn: UIButton!
   @IBOutlet var edit_lessonsText_Btn: UIButton!
   @IBOutlet var copyText_forGoogleApp_Btn: UIButton!
   @IBOutlet var sentenceProgressIndex_End: UIButton!
   @IBOutlet var arrowUnderHideKeyboard_Btn: UIButton!
   @IBOutlet var sentenceProgressIndex_Start: UIButton!
   @IBOutlet var background_ITV_One_showAllText: UIButton!
   @IBOutlet var labelText_LearnL: UILabel!
   @IBOutlet var lessonName_Label: UILabel!
   @IBOutlet var learnLevelIndex_Label: UILabel!
   @IBOutlet var background_lessonName: UILabel!
   @IBOutlet var background_Middle_Btns: UILabel!
   @IBOutlet var howMuchWords_inSentence: UILabel!
   @IBOutlet var countryFlags_SwitchField1: UILabel!
   @IBOutlet var countryFlags_SwitchField2: UILabel!
   @IBOutlet var inputTextView_One: UITextView!
   @IBOutlet var extracted_textView: UITextView!
   @IBOutlet var inputTextView_Second: UITextView!
   @IBOutlet var progressBar: UIProgressView!
   @IBOutlet var podpis: UIImageView!
   @IBOutlet var image_CFlags_LearnL: UIImageView!
   @IBOutlet var tapGesture: UITapGestureRecognizer!
   @IBOutlet var next_prev_words_PanGesture: UIPanGestureRecognizer!
   @IBOutlet var test_label: UILabel!
   
   override func viewDidLoad()
	{
		super.viewDidLoad()

		MonitorNetwork()

		Shadow_Buttons(menu_Btn!)
		Shadow_Buttons(speaker_Btn!)
		Shadow_Buttons(clearTxt_Btn!)
		Shadow_Buttons(hideKeyboard_Btn!)
		Shadow_Buttons(iKnowThisWord_btn!)
		Shadow_Buttons(seeTranslation_Btn!)
		Shadow_Buttons(sentencesLength_Btn!)
		Shadow_Buttons(edit_lessonsText_Btn!)
		Shadow_Buttons(learnLevelIndex_Label!)
		Shadow_Buttons(howMuchWords_inSentence!)
		Shadow_Buttons(copyText_forGoogleApp_Btn!)
		Shadow_Buttons(arrowUnderHideKeyboard_Btn!)

		Shadow_Sentences(progressBar!)
		Shadow_Sentences(lessonName_Label!)
		Shadow_Sentences(inputTextView_One!)
		Shadow_Sentences(extracted_textView!)
		Shadow_Sentences(inputTextView_Second!)
		Shadow_Sentences(sentenceProgressIndex_End!)
		Shadow_Sentences(sentenceProgressIndex_Start!)

		SentenceIndexBorder(sentenceProgressIndex_End!)
		SentenceIndexBorder(sentenceProgressIndex_Start!)

		Shadow_LearnLngBtn_Text(chooseLanguage_Btn.titleLabel!)
		Shadow_LearnLngBtn_Text(sentenceProgressIndex_End.titleLabel!)
		Shadow_LearnLngBtn_Text(sentenceProgressIndex_Start.titleLabel!)

		BtnsBorder(iKnowThisWord_btn!)
		BtnsBorder(guessTheLetter_Btn!)

		speakerSynthesizer.delegate = self
		edit_lessonsText_Btn.isEnabled = false

		//Скриване на клавиаурата при натискане отстрани
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.HideKeyboard))
		view.addGestureRecognizer(tap)

		let didAppEnterBackground = NotificationCenter.default
		didAppEnterBackground.addObserver(self, selector: #selector(AppEnterInactive),   name: UIApplication.willResignActiveNotification,   object: nil)
		didAppEnterBackground.addObserver(self, selector: #selector(AppEnterForeground), name: UIApplication.didBecomeActiveNotification,    object: nil)
		didAppEnterBackground.addObserver(self, selector: #selector(AppEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

		speaker_Btn.setImage(UIImage(systemName: ""), for: .normal)
		hideKeyboard_Btn.setImage(UIImage(systemName: ""), for: .normal)
		seeTranslation_Btn.setImage(UIImage(systemName: ""), for: .normal)

		speaker_Btn.setTitle("🔈", for: .normal)
		hideKeyboard_Btn.setTitle("⌨️", for: .normal)
		seeTranslation_Btn.setTitle("⬇️", for: .normal)

		words_forLearning_Str = "]_[Words_toLearn]"
		lesson_forLearning_Str = "-Lesson]_#_"

		//------------------------ Set Font --------------------------
		fontName = saveSettings_Dictionary.string(forKey: "Font_Name") ?? "Arial"

		//		chooseLanguage_Btn.titleLabel!.font =    UIFont(name: fontName, size: 20)
		//		menu_Btn.titleLabel!.font =              UIFont(name: fontName, size: 20)
		//		sentencesLength_Btn.titleLabel!.font =   UIFont(name: fontName, size: 20)
		//		learnLevelIndex_Label.font =             UIFont(name: fontName, size: 20)
		//		showAllLessonText_Btn.titleLabel!.font = UIFont(name: fontName, size: 20)
		//		lessonName_Label.font =                  UIFont(name: fontName, size: 20)

		inputTextView_One.font = UIFont(name: fontName, size: index_textSize)
		inputTextView_Second.font = UIFont(name: fontName, size: index_textSize)
		extracted_textView.font = UIFont(name: fontName, size: index_textSize)
		//--------------------------------------------------------

		inputTextView_One.text = saveSettings_Dictionary.string(forKey: "FontColor") // В края имаше ! удивителна. И даваше грешка.
		_ = Color_FindAttributedText_CMD()
		inputTextView_One.text = nil

		///Методи за наблюдение за показване и скриване на клавиатурата
		NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow_Height), name:UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
	}

   ///A-----------↓
   ///B-----------↓
   ///C-----------↓
   @IBAction func ClearTextField_Btn(_ sender: Any)
   {
      Shadow_Buttons(clearTxt_Btn!)
      if (timer_ShowStartText.isValid == true) { return }
      if (Color_FindAttributedText_CMD() == true) { return }
      
      inputTextView_One.becomeFirstResponder()
      tapGesture.isEnabled = false
   }
   @IBAction func ClearBtn_TouchDown_Repeate(_ sender: Any)
   {
      Shadow_Buttons(clearTxt_Btn!)
      if (timer_ShowStartText.isValid == true) { return }
      
      inputTextView_One.text = ""
      inputTextView_One.becomeFirstResponder()
      tapGesture.isEnabled = false
   }
   @IBAction func ChooseLanguage_Btn(_ sender: Any)
   {
      //Смяна на езика на говорене
      let languagesToLearn_Arr = [String](arrayLiteral: "English", "Swedish", "Deutche", "Italian")
      
      voiceChoice_Int += 1
      if(voiceChoice_Int > 3){ voiceChoice_Int = 0 }
      
      if(voiceChoice_Int == 0){
         chooseLanguage_Btn.setBackgroundImage(UIImage(named: "English-Flag.png"), for: .normal)
         googleTransURL_Str = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=bg&dt=t&dt=t&q="
         iKnowThisWord_btn.setTitle("I know this", for: .normal)
      }
      else if (voiceChoice_Int == 1){
         chooseLanguage_Btn.setBackgroundImage(UIImage(named: "Sweden-Flag.png"), for: UIControl.State.normal)
         googleTransURL_Str = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=sv&tl=bg&dt=t&dt=t&q="
         iKnowThisWord_btn.setTitle("Jag vet det", for: .normal)
      }
      else if (voiceChoice_Int == 2){
         chooseLanguage_Btn.setBackgroundImage(UIImage(named: "Germany-Flag.png"), for: UIControl.State.normal)
         googleTransURL_Str = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=de&tl=bg&dt=t&dt=t&q="
         iKnowThisWord_btn.setTitle("Ich weiß, dass", for: .normal)
      }
      else if (voiceChoice_Int == 3){
         chooseLanguage_Btn.setBackgroundImage(UIImage(named: "Italy-Flag.png"), for: UIControl.State.normal)
         googleTransURL_Str = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=it&tl=bg&dt=t&dt=t&q="
         iKnowThisWord_btn.setTitle("So che", for: .normal)
      }
      chooseLanguage_Btn.setTitle(languagesToLearn_Arr[voiceChoice_Int], for: UIControl.State.normal)
      selectedLanguage_Str = "[" + languagesToLearn_Arr[voiceChoice_Int]
      
      if(isAllLessonText == true){
         Timer_HideAllLessonTextAndField()
		}
      else {
         ChangeLanguage_ClearInputTV_One()
         if(alphabetShowHide_isShow == true) { ResetStatistic_ShowVocalLetters() }
         else { Timer_ShowStartText() }
      }
      HideKeyboard()
      edit_lessonsText_Btn.isEnabled = false
      UIButton.transition(with: chooseLanguage_Btn, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: {_ in })
  
      count_nweWorldsToLearn = 0
   }
   @IBAction func CopyText_OpenGTranslate(_ sender: Any)
   {
      Shadow_Buttons(copyText_forGoogleApp_Btn!)
      UIPasteboard.general.string = inputTextView_One.text
      
      //Метод за отваряне на друго приложение
      let googleTranslateURL = URL(string: "googletranslate://")
      UIApplication.shared.open(googleTranslateURL!)
   }
   ///E-----------↓
   ///G-----------↓
   @IBAction func GuessLetter_Btn(_ sender: Any)
   {
      Shadow_Buttons(guessTheLetter_Btn!)
      
      extracted_textView.isHidden = false
      
      if(isPlayAplhabet_Pressed == false)
      {
         isPlayAplhabet_Pressed = true
         Remove_AlphabetBtnsFromView()
         Choose_AlphabetLetters()
         Create_AlphabetButtons()
         Show_AlphabetLettersToView()
      }
      if(spokenL == "" && alphabetL == "")
      {
         let randIndex:Int = Int.random(in:0..<alphabetLetters_StringArr.count)
         getRandomIndex = randIndex
         let compareButton: UIButton = UIButton()
         
         Speak_AlphabetLetter(alphabetBtns_Arr[getRandomIndex])
         CompareGuessLetter(alphabetBtns_Arr[randIndex], compareButton)
      }
      else { Speak_AlphabetLetter(alphabetBtns_Arr[getRandomIndex]) }
   }
   ///H-----------↓
   @IBAction func HideKeyboard_Btn(_ sender: Any)
   {
      Shadow_Buttons(hideKeyboard_Btn!)
      Shadow_Buttons(arrowUnderHideKeyboard_Btn!)
      HideKeyboard()
   }
   ///I-----------↓
   @IBAction func I_KnowThisWord_Btn(_ sender: Any) // UserDefaults. Learned words
   {
      //Взима се научената дума за да се сложи Dictionary-то като вече научена дума и се изтрива от масива с думи за учене
      Shadow_Buttons(iKnowThisWord_btn!)
      iKnowThisWord_btn.isEnabled = false
      //		showAllLessonText_Btn.isEnabled = false
      
      var newWords_withoutDeleted_Str = ""
      var newLearnedWord_forCounting_key = ""
      
      newLearnedWord_forCounting_key = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
      sentencesConnectedParts_fromTheLesson_Arr.remove(at: index_sentencePos)
      
      index_sentencePos -= 1
      
      //		if(index_sentencePos < 0) {
      //			index_sentencePos = -1 }
      
      if(sentencesConnectedParts_fromTheLesson_Arr.count > 0)
      {
         for index in 0...sentencesConnectedParts_fromTheLesson_Arr.count - 1 // Думите, без изтритата, се записват в променлива за да се презапишат във файла
         {
            newWords_withoutDeleted_Str += sentencesConnectedParts_fromTheLesson_Arr[index] + "\n"
         }
      }
      //---------------------------------------------------
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         //Create and append lesson file
         let savedNewWordFileURL = dir.appendingPathComponent(selectedLanguage_Str + words_forLearning_Str + ".txt")
         
         //Writing into file and into saveSettings_Dictionary
         do { try newWords_withoutDeleted_Str.write(to: savedNewWordFileURL, atomically: true, encoding: .utf8) }
         catch {}
      }
      //---------------------------------------------------
      //Когато се изтрие дума за учене, значи е научена и броя на научените думи се увеличава
      let learnedWords_value = "LEARNED_" + selectedLanguage_Str + words_forLearning_Str.replacingOccurrences(of: ".txt", with: "")
      let search_learnedWord_value = count_LearnedWords_Dictionary.value(forKey: newLearnedWord_forCounting_key)
      
      //Когато думата стане равна на "2", значи, че е учена над два пъти и вероятно е научена и запомнена.
      if(search_learnedWord_value == nil) {
         count_LearnedWords_Dictionary.set("1", forKey: newLearnedWord_forCounting_key)
      }
      else if(search_learnedWord_value as! String == "1") {
         count_LearnedWords_Dictionary.set("2", forKey: newLearnedWord_forCounting_key)  // Ключът е думата, защото трябва да е различен. А думите са различни
      }
      else if(search_learnedWord_value as! String == "2") { // learned_Words_InLanguage_Key
         count_LearnedWords_Dictionary.set(learnedWords_value, forKey: newLearnedWord_forCounting_key)  // Ключът е думата, защото трябва да е различен. А думите са различни
      }
      
      var delWordMessage = "This word was deleted from the words list." //NSMutableAttributedString(string: "This word was deleted from the words list.")
      if(sentencesConnectedParts_fromTheLesson_Arr.count < 1)
      {
         sentenceOrWord_AfterShowingAllText = ""
         index_sentencePos = -1
         delWordMessage = "😀😃🧐 \nYeee, the words list is empty!" //NSMutableAttributedString(string: "😀😃🧐 \nYeee, the words list is empty!")
         ReturnThisLessonOrGoNext()
      }
      extracted_textView.attributedText = CreateAttributedString(delWordMessage)
      extracted_textView.isHidden = false
      ProgressBar_Progress()
   }
   ///M-----------↓
   @IBAction func Menu_Btn(_ sender: Any)
   {
      Shadow_Buttons(menu_Btn!)
      HideKeyboard()
      
      if(voiceChoice_Int == -1) { Show_IsNoLanguageSelected_Alert(); return }
      isMenuShow = true
      
      let nextLesson_name = CheckForLastLesson()
      
      count_nweWorldsToLearn = Check_WorldsToLearnCount()
      
      let loadLesson = UIAlertAction(title: "📖      Load a lesson", style: .default, handler: { [self] ACTION in Load_ListOfLessonsFiles() })
      loadLesson.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let nextLesson = UIAlertAction(title: "➡️      \(nextLesson_name)", style: .default, handler: { [self] ACTION in Load_NextOrLastLesson(nextLesson_name) })
      nextLesson.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let savedWords = UIAlertAction(title: "📝      Saved words                         \(count_nweWorldsToLearn)", style: .default, handler: { [self]ACTION in Load_SavedWordsToLearn()})
      savedWords.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let saveLesson = UIAlertAction(title: "💾      Save a lesson", style: .default, handler: { [self] ACTION in SaveLesson_Method() })
      saveLesson.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let learnAlphabet = UIAlertAction(title: "🔠      Learn alphabet", style: .default, handler:
                                          { [self] ACTION in Show_Hide_AlphabetLetters(); isMenuShow = false })
      learnAlphabet.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let fontSize = UIAlertAction(title: "➕➖ Font size",  style: .default, handler:
                                    { [self] ACTION in
         let textSize = UIAlertController(title: nil, message: "Size: \(index_textSize)", preferredStyle: .alert)
         textSize.addAction(UIAlertAction(title: "➕", style: .default, handler: {[self] ACTION in TextHeight_Max();  Present_Method(textSize) } ))
         textSize.addAction(UIAlertAction(title: "➖", style: .default, handler: {[self] ACTION in TextHeight_Min();  Present_Method(textSize) } ))
         Present_Method(textSize)
      })
      fontSize.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let speedSpeaking = UIAlertAction(title: "\(imageNumber)      Speaking rate", style: .default, handler:
                                          { [self] ACTION in
         let speedSpeakNumber = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
         speedSpeakNumber.addAction(UIAlertAction(title: "\(imageNumber)", style: .default, handler:
                                                   { [self] ACTION in
            SpeakingSpeed()
            speedSpeakNumber.actions[0].setValue("\(imageNumber)", forKey: "title")
            Present_Method(speedSpeakNumber) })
         )
         Present_Method(speedSpeakNumber) }
      )
      speedSpeaking.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let deleteLesson = UIAlertAction(title: "🗑      Delete lesson!", style: .destructive, handler:{ [self]ACTION in Delete_LessonsFiles() })
      deleteLesson.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      let info = UIAlertAction(title: "ℹ️      Info", style: .default, handler:{ [self]ACTION in Info_Program() })
      info.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //-----------------------------------------------
      
      let menu = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
      menu.addAction(loadLesson)
      menu.addAction(nextLesson)
      menu.addAction(savedWords)
      menu.addAction(saveLesson)
      menu.addAction(learnAlphabet)
      menu.addAction(fontSize)
      menu.addAction(speedSpeaking)
      menu.addAction(deleteLesson)
      menu.addAction(info)
      menu.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { [self] ACTION in isMenuShow = false } ))
      Present_Method(menu)
   }
   @IBAction func MiddleBtnsMove_PanGesture(_ panGesture: UIPanGestureRecognizer)
	{
		let translation = panGesture.translation(in: view)

		guard  let btnThatMoves = panGesture.view as? UIButton
		else { return }

		if(panGesture.state == .began) {
			view.bringSubviewToFront(panGesture.view!)
			btnThatMoves_PrevPosX = btnThatMoves.frame.minX
		}

		if(panGesture.view == iKnowThisWord_btn) {
			btnThatMoves.center = CGPoint(x: btnThatMoves.center.x + translation.x, y: btnThatMoves.center.y + translation.y)

			if(panGesture.state == .ended) {
				//Restore_ShadowButtonsIfTouchedOutside()
				Shadow_Buttons(iKnowThisWord_btn!)
			}
		}
		else { btnThatMoves.center = CGPoint(x: btnThatMoves.center.x + translation.x, y: btnThatMoves.center.y)

			if(panGesture.view == hideKeyboard_Btn) {
				arrowUnderHideKeyboard_Btn.frame = CGRect.init(x: hideKeyboard_Btn.frame.minX, y: hideKeyboard_Btn.frame.midY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height) }

			MiddleBtnsSwapping_withFinger(panGesture, btnThatMoves)
		}
      
      panGesture.setTranslation(.zero, in: view)
   }
   ///N-----------↓
   @IBAction func Next_Prev_Word_PanGesture(_ panGesture: UIPanGestureRecognizer)
   {
      if(sentencesConnectedParts_fromTheLesson_Arr.count <= 0) { return }
      //---------------------------------------------------------------------------
      velocity = panGesture.velocity(in: view).x
      gestureDirection_X = CGFloat(panGesture.translation(in: self.view).x)
      posX_objMove = panGesture.translation(in: self.view).x + CGFloat(view.frame.maxX) / 75 // +5 отляво
      //---------------------------------------------------------------------------
      
      if(panGesture.state == .began) // За първото прихващане на селдващото или предишното изречение
      {
         inputTextView_Second.isHidden = false
         timer_SlidingInputTextView.invalidate()
      }
      //---------------------------------------------------------------------------
      // За постоянно движение на inputTextView_One/_Second, когато плъзгам наляво или надясно
      if(gestureDirection_X < 0)
      {
         let posXleft_ViewSecond = view.frame.width * 1.0133 + gestureDirection_X // Трябва да е на 380
         inputTextView_One.frame =    CGRect.init(x: posX_objMove,        y: inputTextView_One.frame.minY,    width: inputTextView_One.frame.width,    height: inputTextView_One.frame.height)
         inputTextView_Second.frame = CGRect.init(x: posXleft_ViewSecond, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
         extracted_textView.frame =   CGRect.init(x: posX_objMove,        y: extracted_textView.frame.minY,   width: extracted_textView.frame.width,   height: extracted_textView.frame.height)
      }
      else if(gestureDirection_X > 0)
      {
         let posXRight_ViewSecond = -view.frame.width / 1.0133 + gestureDirection_X
         inputTextView_One.frame =    CGRect.init(x: posX_objMove,         y: inputTextView_One.frame.minY,    width: inputTextView_One.frame.width,    height: inputTextView_One.frame.height)
         inputTextView_Second.frame = CGRect.init(x: posXRight_ViewSecond, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
         extracted_textView.frame =   CGRect.init(x: posX_objMove,         y: extracted_textView.frame.minY,   width: extracted_textView.frame.width,   height: extracted_textView.frame.height)
      }
      //---------------------------------------------------------------------------
      if(gestureDirection_X > 0 && isRightSlideBegan == true) // За първото прихващане на следващото или предишното изречение
      {
         if(isLeftSlideBegan == false && isRightSlideBegan == true) // Ако се плъзне наляво и без да се пуска екрана се плъзне надясно
         {
            index_sentencePos -= 1
            if(isSavedWords == false) {
               theSum_ofAllConnectedSentences -= theSum_ofConnectedSentences_Arr[index_sentencePos] }
         }
         PrevSentence_Method()
         isRightSlideBegan = false
         isLeftSlideBegan = true
      }
      else if(gestureDirection_X < 0 && isLeftSlideBegan == true) // За първото прихващане на следващото или предишното изречение
      {
         if(isLeftSlideBegan == true && isRightSlideBegan == false)// Ако се плъзне наляво и без да се пуска екрана се плъзне надясно
         {
            index_sentencePos += 1
            if(isSavedWords == false) {
               theSum_ofAllConnectedSentences += theSum_ofConnectedSentences_Arr[index_sentencePos] }
         }
         NextSentence_Method()
         isRightSlideBegan = true
         isLeftSlideBegan = false
      }
      
      //test_label.text = "\(gestureDirection_X)   \(isRightSlideBegan)"
      //---------------------------------------------------------------------------
      if(panGesture.state == .ended)
      {
         //test_label.text = "\(gestureDirection_X)   \(isRightSlideBegan)"
         
         if(gestureDirection_X < 0 && velocity > 500  && inputTextView_One.frame.minX < 0)                    { isITV_OneX_notInScreen = true } // Имаше проблем със следващото и предишното изречения, когато се плъзга бързо на ляво и дясно
         else if(gestureDirection_X > 0 && velocity < -500 && inputTextView_One.frame.maxX > view.frame.maxX) { isITV_OneX_notInScreen = true }
         
         let timeIntervalS = 0.0002
         var timeInterval =  0.0001
         if(velocity > 3000 || velocity < -3000) { timeInterval = 0.00002 }
         
         if(velocity > 500)       { gestureDirection_X =  151 }
         else if(velocity < -500) { gestureDirection_X = -151 }
         
         if(isNoPrev_NextText == false)
         {
            //Два таймера за завършване на движението на inputTextView, на ляво и дясно
            if(gestureDirection_X > dist_halfScreen || velocity > 500) {
               viewMaxX = view.frame.width * 1.0133
               next_prev_words_PanGesture.isEnabled = false
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(InputTextView_RightSliding), userInfo: nil, repeats: true)
            }
            else if(gestureDirection_X < -dist_halfScreen || velocity < -500) {
               viewMaxX = view.frame.width / 1.01388
               next_prev_words_PanGesture.isEnabled = false
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(InputTextView_LeftSliding), userInfo: nil, repeats: true)
            }
            //Два таймера за връщане на изречението ако не е плъзнато след определената дистанция
            else if (gestureDirection_X < dist_halfScreen && gestureDirection_X > 0) {
               viewMaxX = view.frame.width / 75
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeIntervalS, target: self, selector: #selector(InputTextView_NotPassCenterScreen_forPrev), userInfo: nil, repeats: true)
            }
            else if (gestureDirection_X > -dist_halfScreen && gestureDirection_X < 0) {
               viewMaxX = view.frame.width / 75
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeIntervalS, target: self, selector: #selector(InputTextView_NotPassCenterScreen_forNext), userInfo: nil, repeats: true)
            }
         }
         else if(isNoPrev_NextText == true)
         {
            viewMaxX = view.frame.width / 75
            if(gestureDirection_X > 0 && index_sentencePos <= 0) {
               next_prev_words_PanGesture.isEnabled = false
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeIntervalS, target: self, selector: #selector(InputTextView_noMorePrevText_Slide), userInfo: nil, repeats: true)
            }
            else if(gestureDirection_X < 0 && index_sentencePos >= sentencesConnectedParts_fromTheLesson_Arr.count - 1) {
               next_prev_words_PanGesture.isEnabled = false
               timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: timeIntervalS, target: self, selector: #selector(InputTextView_noMoreNextText_Slide), userInfo: nil, repeats: true)
            }
         }
      }
   }
   ///R-----------↓
   @IBAction func Return_StartOfTheLesson_Btn()
   {
      if(index_sentencePos > 5 && sentencesConnectedParts_fromTheLesson_Arr.count > 0)
      {
         returnToStartOfTheLesson = UIAlertController(title: "↩️ Return to the lesson beginning?", message: nil, preferredStyle: .alert)
         returnToStartOfTheLesson.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] ACTION in Return_ToStartOfTheLesson() }))
         returnToStartOfTheLesson.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
         Present_Method(returnToStartOfTheLesson)
      }
   }
   ///S-----------↓
   @IBAction func Speaker()
   {
      Shadow_Buttons(speaker_Btn!)
      
      if(googleTransURL_Str != "")
      {
         //Превеждане заедно с говоренето, ако не е завършен урока    //И ако е вече преведено да не превежда отново
         if(isSavedWords == false && extracted_textView.isHidden == true && learnedLessonMarker != learnedLessonSymbol && speakerSynthesizer.isSpeaking == false) {
            
            SeeTranslation()
            Save_EndSentence_GreenProgressBar()
         }
         var speakText = AVSpeechUtterance()
         let speakVoiceArr = [String](arrayLiteral:"en-GB", "sv-SE", "de-DE","it-IT")
         
         if (speakerSynthesizer.isSpeaking == false && speakerSynthesizer.isPaused == false && voiceChoice_Int > -1)
         {
            //Подготвяне на гласа
            speakText = AVSpeechUtterance(string: inputTextView_One.text)
            speakText.rate = Float(speedSpeak_index)
            speakText.voice = AVSpeechSynthesisVoice(language: "\(speakVoiceArr[voiceChoice_Int])")
            
            //Изговаряне на текста
            speakerSynthesizer.speak(speakText)
            speaker_Btn.setTitle("🔊", for: .normal)
         }
         else if (speakerSynthesizer.isSpeaking == true && speakerSynthesizer.isPaused == false)  //Като се натиснe бутона докато се говори за пауза или стоп
         {
            if(isSavedWords == true) { return }
            
            speakerSynthesizer.stopSpeaking(at: .immediate)
            //speaker_Btn.setTitle("🔇", for: .normal)
         }
         //else if (speakerSynthesizer.isSpeaking == true && speakerSynthesizer.isPaused == true)
        //{
        //   speakerSynthesizer.continueSpeaking()
        //   speaker_Btn.setTitle("🔊", for: .normal)
        //}
      }
      else {
         extracted_textView.isHidden = false
         extracted_textView.text = "😎🧐 Oops\nThere is no language to speak."
      }
   }
   @IBAction func SeeTranslation()
   {
      HideKeyboard()
      //		isClearOrEditText = 1
      tapGesture.isEnabled = true
      Shadow_Buttons(seeTranslation_Btn!)
      
      if( voiceChoice_Int == -1) { extracted_textView.isHidden = false;  extracted_textView.text = "😎🧐 Oops\nChoose a language.";  return }
      
      if(alphabetShowHide_isShow == true || timer_seeTranslationAnimateClock.isValid == true) { return }
      
      if(inputTextView_One.text.isEmpty) {
         inputTextView_One.text =  "..."
         extracted_textView.attributedText = nil
         extracted_textView.isHidden = true
         return
      }
      else if(isSavedWords == true) {
         someTouchedWord = inputTextView_One.text
         MakeTouchedWordReadyToTranslate(inputTextView_One.text)
      }
      else {
         GoogleTranslate(inputTextView_One.text)
         SeeTranslation_AnimatedClock()
      }
   }
   @IBAction func SeeTranslation(_ sender: Any)
   {
      isSeeTranslBtn_pressed = true
   }
   @IBAction func SentencesLength(_ sender: Any)
   {
      Shadow_Buttons(sentencesLength_Btn!)
      if(isSavedWords == true || isAllLessonText == true || lessonFileName.contains("LEARNED_") ){ return }
      
      // Дължина на текста за учене
      sentenceLength_Level += 1
      
      if (sentenceLength_Level > 3) { sentenceLength_Level = 1 }
      learnLevelIndex_Label.text = "\(sentenceLength_Level)"
      
      // Автоматично прилагане на дължина на изречение
      if(lessonSentencesAndWords_Arr.count > 0) //Ако не е зареден урок
      {
         Get_SentenceIndex()
         if(sentenceLength_Level == 1)      { Connect_OnePartOfSentence() }
         else if(sentenceLength_Level == 2) { Connect_TwoPartsOfSentence() }
         else if(sentenceLength_Level == 3) { Connect_WholeSentenceFromLesson() }
         //else if(sentenceLength_Level == 4) { Get_TwoWholeSentencesFromLesson() }
         
         FindPosition_WhenChangeTheLessonLevel (theSum_ofConnectedSentences_Arr)
         
         if(index_sentencePos > sentencesConnectedParts_fromTheLesson_Arr.count - 1) {
            index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1}
         sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]  // Взима изречение на определената позиция
         
         setTextTo_ITV_One = true
         CreateSentence()
         ProgressBar_Progress()
      }
   }
   @IBAction func ShadowButtonsPressed(_ sender: Any)
   {
      if((sender as! NSObject)      == menu_Btn)                  { Shadow_ButtonsPressed_Method(menu_Btn!) }
      else if((sender as! NSObject) == speaker_Btn)               { Shadow_ButtonsPressed_Method(speaker_Btn!) }
      else if((sender as! NSObject) == clearTxt_Btn)              { Shadow_ButtonsPressed_Method(clearTxt_Btn!) }
      else if((sender as! NSObject) == hideKeyboard_Btn)          { Shadow_ButtonsPressed_Method(hideKeyboard_Btn!); Shadow_ButtonsPressed_Method(arrowUnderHideKeyboard_Btn!) }
      else if((sender as! NSObject) == iKnowThisWord_btn)         { Shadow_ButtonsPressed_Method(iKnowThisWord_btn!) }
      else if((sender as! NSObject) == seeTranslation_Btn)        { Shadow_ButtonsPressed_Method(seeTranslation_Btn!) }
      else if((sender as! NSObject) == guessTheLetter_Btn)        { Shadow_ButtonsPressed_Method(guessTheLetter_Btn!) }
      else if((sender as! NSObject) == sentencesLength_Btn)       { Shadow_ButtonsPressed_Method(sentencesLength_Btn!) }
      else if((sender as! NSObject) == edit_lessonsText_Btn)     { Shadow_ButtonsPressed_Method(edit_lessonsText_Btn!) }
      else if((sender as! NSObject) == copyText_forGoogleApp_Btn) { Shadow_ButtonsPressed_Method(copyText_forGoogleApp_Btn!) }
   }
   @IBAction func Speak_SavedWords(_ longGesture: UILongPressGestureRecognizer)
   {
      if(longGesture.state == .began)
      {
         if(isSpeak_savedWords == false && isSavedWords == true) {
            isSpeak_savedWords = true
            speaker_Btn.alpha = 0.6
            Speaker()
         }
         else if(isSpeak_savedWords == true && isSavedWords == true) {
            speaker_Btn.alpha = 1
            isSpeak_savedWords = false
            Speaker()
         }
      }
   }
   ///T-----------↓
   @IBAction func TapGesture_InputTextView(_ sender: Any)
   {
      if(voiceChoice_Int == -1)                     { return }
      else if (timer_ShowStartText.isValid == true) { return }
      else if (isSavedWords == true)                { return }

      let point = tapGesture.location(ofTouch: 0, in: inputTextView_One)//.location(in: inputTextView_One)
      let detectedWord = TouchedWordAtPosition(point)
      
      if (detectedWord != "")
      {
         //------------ Моя код ------------
         if(isRepeatedWord != detectedWord) // Helvetica Neue
         {
            //let range = (inputTextView_One.text! as NSString).range(of: detectedWord!)
            
            let ITV_O_Word = CreateAttributedString(inputTextView_One.text!)
            ITV_O_Word.addAttribute(NSAttributedString.Key.underlineStyle, value: 1.9, range: (inputTextView_One.text! as NSString).range(of: detectedWord!))
            inputTextView_One.attributedText = ITV_O_Word
            //--------------------------------------------------------
            someTouchedWord = detectedWord!
            isRepeatedWord = someTouchedWord
            
            Save_NewWordsForLearning(someTouchedWord)
            Paste_TouchedWordToTextView(someTouchedWord)
            Alert_WhenNewWordsIsMany()
         }
         else {
            Paste_TwoTimeTouchedWordToTextView(someTouchedWord)
         }
         isSomeWord_Pressed = true
         extracted_textView.isHidden = false
      }
      //----------------------------------
   }
   //MARK: @IBAction Buttons ---↑
   
   
   //MARK: @objc    Function ---↓
   ///A-----------↓
   @objc func AppEnterInactive()
   {
      if(alphabetShowHide_isShow == true) {
         Show_Hide_AlphabetLetters()
         isMenuShow = true
      }
      HideKeyboard()
   }
   @objc func AppEnterForeground()
   {
      if(isSavedWords == true) {
         iKnowThisWord_btn.isHidden = false }

		if(podpis.isHidden == false) {
			Hide_Image_AppEnterForeground()
			image_CFlags_LearnL.isHidden = true
			labelText_LearnL.isHidden = true
		}
   }
   @objc func AppEnterBackground()
   {
      podpis.isHidden = true
      ActivityClock_Translation_Done()
      
      if(isMenuShow == true) { // Hide the menu alert to not show above the country flags image.
         self.dismiss(animated: true, completion: nil)
      }
      
      fontColor_Alert.dismiss(animated: false, completion: nil)
      returnOrNextLesson.dismiss(animated: false, completion: nil)
      returnToStartOfTheLesson.dismiss(animated: false, completion: nil)
      
//      UIView.transition(from: countryFlags_SwitchField1, to: image_CFlags_LearnL, duration: 0, options: .transitionCurlDown, completion: nil)
//      UIView.transition(from: countryFlags_SwitchField2, to: labelText_LearnL,    duration: 0, options: .transitionCurlDown, completion: nil)
   }
   func       Alert_WhenNewWordsIsMany() ///----     NEW method 5.11.2023      -----
   {
      if(count_nweWorldsToLearn == 50 || count_nweWorldsToLearn == 60 || count_nweWorldsToLearn == 70
      || count_nweWorldsToLearn == 80 || count_nweWorldsToLearn == 90 || count_nweWorldsToLearn == 100)
      {
         var alertMessage = ""
              if(selectedLanguage_Str == "[English") { alertMessage = "New words are:" }
         else if(selectedLanguage_Str == "[Swedish") { alertMessage = "De nya orden är:" }
         else if(selectedLanguage_Str == "[Deutche") { alertMessage = "Neue Wörter sind:" }
         else if(selectedLanguage_Str == "[Italian") { alertMessage = "Le nuove parole sono:" }
         
         let alert_manyNewWords = UIAlertController(title: "\(alertMessage) \(count_nweWorldsToLearn)", message: nil, preferredStyle: .alert)
         Present_Method(alert_manyNewWords)
      }
   }
   func       ActivityClock_Translation_Done() //🕛 - Stop Timer
   {
      timer_seeTranslationAnimateClock.invalidate()
      seeTranslation_Btn.setImage(nil, for: .normal)
      seeTranslation_Btn.setTitle("⬇️", for: .normal)
   }
   ///B-----------↓
   func       BtnsBorder(_ btn: Any)
   {
      (btn as AnyObject).layer.cornerRadius = 5
		(btn as AnyObject).layer.borderWidth = 1.2
      (btn as AnyObject).layer.borderColor = UIColor.darkGray.cgColor
   }
   ///C-----------↓
   func       CreateSentence() //------------//=//=//=//------------
   {
      if(setTextTo_ITV_One == true)
      {
         inputTextView_One.attributedText = CreateAttributedString(sentenceOrWord_AfterShowingAllText)
         setTextTo_ITV_One = false
      }
      else {
         inputTextView_Second.attributedText = CreateAttributedString(sentenceOrWord_AfterShowingAllText)
      }
   }
   func       Choose_AlphabetLetters()
   {
      //Създаване на буквите
      if(voiceChoice_Int == 0)
      {
         let alphabetVocalLettersEN_arr = [String](arrayLiteral: "a","c","d","e","h","i","g","j","o","t","u","v","y")
         let alphabetLettersEN_arr = [String](arrayLiteral: "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
         
         if(isPlayAplhabet_Pressed == true) {
            alphabetLetters_StringArr = alphabetVocalLettersEN_arr
         }
         else { alphabetLetters_StringArr = alphabetLettersEN_arr }
      }
      else if (voiceChoice_Int == 1) {
         let alphabetVocallLettersSV_arr = [String](arrayLiteral: "a","e","i","j","o","u","y","å","ä","ö")
         let alphabetLettersSV_arr = [String](arrayLiteral: "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","å","ä","ö")
         
         if(isPlayAplhabet_Pressed == true) {
            alphabetLetters_StringArr = alphabetVocallLettersSV_arr
         }
         else { alphabetLetters_StringArr = alphabetLettersSV_arr }
      }
      else if (voiceChoice_Int == 2) {
         let alphabetVocalLettersDE_arr = [String](arrayLiteral: "b", "c", "d", "e", "f", "h", "i", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "z")
         let alphabetLettersDE_arr = [String](arrayLiteral: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "ö", "ü", "ß")
         
         if(isPlayAplhabet_Pressed == true) {
            alphabetLetters_StringArr = alphabetVocalLettersDE_arr
         }
         else { alphabetLetters_StringArr = alphabetLettersDE_arr }
      }
      else if (voiceChoice_Int == 3){
         let alphabetVocalLettersIT_arr = [String](arrayLiteral: "a", "b", "c", "d", "e", "f", "g", "h", "i", "m", "n", "o", "p", "s", "u", "v")
         let alphabetLettersIT_arr = [String](arrayLiteral: "a", "b", "c", "d", "e", "f", "g", "h", "i", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "z")
         
         if(isPlayAplhabet_Pressed == true) {
            alphabetLetters_StringArr = alphabetVocalLettersIT_arr
         }
         else { alphabetLetters_StringArr = alphabetLettersIT_arr }
      }
   }
   func       Create_AlphabetButtons()
   {
      var posX:Int = Int(view.frame.width / 19)
      var posY:Int = Int(view.frame.height / 5.5)
      
      for letter in 0...alphabetLetters_StringArr.count - 1
      {
         let buttonChar = UIButton()
         buttonChar.setTitle(alphabetLetters_StringArr[letter], for: .normal)
         buttonChar.backgroundColor = UIColor(red: 1, green: 0.96090737712902896,  blue: 0.82366244195046434, alpha: 0.9)
         buttonChar.setTitleColor(.black, for: .normal)
         buttonChar.titleLabel?.font = UIFont(name: "Charter-Bold", size: 29.0)
         buttonChar.frame = CGRect.init(x: posX, y: posY, width: 31, height: 45)
         
         if(isPlayAplhabet_Pressed == true){
            buttonChar.addTarget(self, action: #selector(GuessSpokenLetter), for: .touchUpInside) }
         else {
            buttonChar.addTarget(self, action: #selector(Speak_AlphabetLetter), for: .touchUpInside)
         }
         buttonChar.addTarget(self, action: #selector(Shadow_ButtonsPressed_Method), for: .touchDown)
         buttonChar.addTarget(self, action: #selector(Shadow_Buttons), for: .touchUpInside)
         
         Shadow_Buttons(buttonChar)
         BtnsBorder(buttonChar)
         
         alphabetBtns_Arr.append(buttonChar)
         
         //Подреждане на бутоните. Размер + отстояние помежду. Височина + отстояние
         posX += 31 + 3
         if(posX > Int(view.frame.width / 1.11)) { posY += 45 + 3; posX = Int(view.frame.width / 19) }}
   }
   func       Connect_OnePartOfSentence()
   {
      // В отделен масив се слагат бройката на долепените изречения за всеки level
      // За всяко ниво се сумират бройката на долепените изречения и се взима позицията за следващото ниво
      // Това става в методите Get_TwoPartsOfSentence(), Get_WholeSentenceFromLesson (), Get_TwoWholeSentencesFromLesson () и Get_TwoWholeSentencesFromLesson () се създават масивите с бройката на долепени изречения
      // В метода Get_IndexWhenChangeTheSentenseLength () се подава масива с бройката на долепените изречения и се изчислява позицията
      // В Get_SentenceIndex() запазвам и бройката на минатите изречения за изчисление на позицията когато сменя Learn level-a
      
      theSum_ofConnectedSentences_Arr = [Int]()
      
      for _ in 0...lessonSentencesAndWords_Arr.count - 1 {
         theSum_ofConnectedSentences_Arr.append(1)
      }
      sentencesConnectedParts_fromTheLesson_Arr = lessonSentencesAndWords_Arr
   }
   func       Connect_TwoPartsOfSentence()
   {
      var index = 0
      var index_IntoLoop = 0
      var amount_sentenceParts = 0
      var twoPartsOfSentence_Str = ""
      theSum_ofConnectedSentences_Arr = [Int]() // Това се пълни наново със сумираната бройка на свързаните изречения
      sentencesConnectedParts_fromTheLesson_Arr = [String]() //Това се пълни наново със свирзани части на изречение
      
      while(index < lessonSentencesAndWords_Arr.count)
      {
         while(index_IntoLoop < 2 && index < lessonSentencesAndWords_Arr.count)
         {
            if(lessonSentencesAndWords_Arr[index].last != "." &&
               lessonSentencesAndWords_Arr[index].last != "!" &&
               lessonSentencesAndWords_Arr[index].last != "?" &&
               lessonSentencesAndWords_Arr[index].last != "\"" )
            {
               if(index_IntoLoop == 1) {
                  twoPartsOfSentence_Str += lessonSentencesAndWords_Arr[index] }
               else { twoPartsOfSentence_Str += lessonSentencesAndWords_Arr[index] + " " } //Долепване на изреченията
               amount_sentenceParts += 1
            }
            else {
               twoPartsOfSentence_Str += lessonSentencesAndWords_Arr[index] //Долепване на изреченията
               index_IntoLoop = 2
               amount_sentenceParts += 1
            }
            index_IntoLoop += 1
            index += 1
         }
         sentencesConnectedParts_fromTheLesson_Arr.append(twoPartsOfSentence_Str) //Добавяне на изреченията в масива за учене
         theSum_ofConnectedSentences_Arr.append(amount_sentenceParts)       //Добавяне на взети и долепени изречения в масива за бройка
         
         twoPartsOfSentence_Str = ""
         index_IntoLoop = 0
         amount_sentenceParts = 0
      }
   }
   func       CheckForThisLesson() -> String
   {
      // Взима се името на сегашния урок и се разделя на масив. От него се отделят символа и номера на урока. Номера се увеличава с едно за следващ урок.
      // Ако нама следващ нищо не прави. Името на урока се сглобява от думите на урока и новото число. Търси се за такъв урок и се изкарва инфо на бутона.
      var thisLesson = ""
      var nextLesson = ""
      if(saveSettings_Dictionary.object(forKey: selectedLanguage_Str + lastOpenedFile_str) != nil)
      {
         thisLesson = saveSettings_Dictionary.object(forKey: selectedLanguage_Str + lastOpenedFile_str) as! String
      }
      else { thisLesson = "End lesson" }
      thisLesson = thisLesson.replacingOccurrences(of: "\"", with: "")
      thisLesson = thisLesson.replacingOccurrences(of: ".txt", with: "")
      thisLesson = thisLesson.replacingOccurrences(of: selectedLanguage_Str, with: "")
      thisLesson = thisLesson.replacingOccurrences(of: lesson_forLearning_Str, with: "")
      
      let lessonSymbol_Arr = thisLesson.components(separatedBy: " ")
      var lessonNumber = lessonSymbol_Arr[lessonSymbol_Arr.count - 1]
      let cutSymbol = lessonNumber.removeFirst()
      var lessonNumber_Int = Int(lessonNumber)
      
      if(lessonNumber_Int != nil)
      {
         lessonNumber_Int! += 1
         
         for i in 0...lessonSymbol_Arr.count - 2 {
            nextLesson += lessonSymbol_Arr[i] + " " }
         
         let lessonNumberStr: String = String(lessonNumber_Int!)
         nextLesson = selectedLanguage_Str + lesson_forLearning_Str + nextLesson + "\(cutSymbol)\(lessonNumberStr)" + ".txt"
         
         let readed_selectedLessonFile_Text = Read_SelectedLessonFile(nextLesson)    //"ReadSelected_LessonFile()" -> Връща "String"
         
         if(readed_selectedLessonFile_Text == "") { nextLesson = "End lesson" }
         else {
            nextLesson = nextLesson.replacingOccurrences(of: ".txt", with: "")
            nextLesson = "\"" + nextLesson.replacingOccurrences(of: selectedLanguage_Str + lesson_forLearning_Str, with: "") + "\""
         }
      }
      else { nextLesson = "End lesson" }
      return nextLesson
   }
   func       CheckForLastLesson() -> String
   {
      // Взима името на сегашния урок
      var thisLesson = ""
      var readedLesson = ""
      if(saveSettings_Dictionary.object(forKey: selectedLanguage_Str + lastOpenedFile_str) != nil)
      {
         thisLesson = saveSettings_Dictionary.object(forKey: selectedLanguage_Str + lastOpenedFile_str) as! String
         readedLesson = Read_SelectedLessonFile(thisLesson)
         
         if(readedLesson == "") {
            Delete_SelectedLessonFile(thisLesson)
            thisLesson = "No last lesson"
         }
         else if(thisLesson.contains("LEARNED_")) {
            thisLesson = ReplacingOccurrences_LessonFileName(thisLesson)
         }
         else {
            thisLesson = thisLesson.replacingOccurrences(of: "\"", with: "")
            thisLesson = thisLesson.replacingOccurrences(of: ".txt", with: "")
            thisLesson = thisLesson.replacingOccurrences(of: selectedLanguage_Str, with: "")
            thisLesson = thisLesson.replacingOccurrences(of: lesson_forLearning_Str, with: "")
         }
      }
      else { thisLesson = "No last lesson" }
      
      return thisLesson
   }
   func       Check_WorldsToLearnCount() -> Int  ///----     NEW method 5.11.2023      -----
   {
      ///Когато се натисне "Menu", метода показва броя на новите думи за учене
      let newWordsToLearn_File = selectedLanguage_Str + words_forLearning_Str + ".txt"
      
      let readed_selectedLessonFile_Text = Read_SelectedLessonFile(newWordsToLearn_File).trimmingCharacters(in: .whitespacesAndNewlines)
      if(readed_selectedLessonFile_Text == "") { return 0 }
      let newWordsToLearn_Arr = readed_selectedLessonFile_Text.components(separatedBy: "\n")
      
      return newWordsToLearn_Arr.count
   }
   func       ChangeLanguage_ClearInputTV_One() //Change 🇬🇧 🇸🇪 🇩🇪 🇮🇹
   {
      //Ако езика се смени по време на учене, всичко се изтрива от предния
      
      spokenL = ""
      alphabetL = ""
      lessonFileName = ""
      isSavedWords = false
      index_sentencePos = -1
      inputTextView_One.text = nil
      extracted_textView.text = nil
      inputTextView_Second.text = nil
      iKnowThisWord_btn.isHidden = true
      extracted_textView.isHidden = true
      sentenceOrWord_AfterShowingAllText = ""
      lessonName_Label.text = "\"Lesson name\""
      lessonSentencesAndWords_Arr = [String]()
      sentencesConnectedParts_fromTheLesson_Arr = [String]()
      inputTextView_One.attributedText = CreateAttributedString(" ")
      Remove_AlphabetBtnsFromView()
      ProgressBar_Progress()
      index_ShowStartTxt = 0
      index_ShowABCletters = 0
      timer_ShowStartText.invalidate()
      tapGesture.isEnabled = true        // За да не се натиска докато се показва стартовия текст
      UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil) // За да не се натиска докато се показва стартовия текст
   }
   func       Connect_WholeSentenceFromLesson ()
   {
      var index = 0
      var amount_sentenceParts = 0
      var wholeSentence_Str = ""
      theSum_ofConnectedSentences_Arr = [Int]() // Това се пълни наново със сумираната бройка на свързаните изречения
      sentencesConnectedParts_fromTheLesson_Arr = [String]() //Това се пълни наново със свирзани части на изречение
      
      while(index < lessonSentencesAndWords_Arr.count)
      {
         if(lessonSentencesAndWords_Arr[index].last != "." &&
            lessonSentencesAndWords_Arr[index].last != "!" &&
            lessonSentencesAndWords_Arr[index].last != "?" &&
            lessonSentencesAndWords_Arr[index].last != "\"" )
         {
            wholeSentence_Str += lessonSentencesAndWords_Arr[index] + " "
            amount_sentenceParts += 1
            
            if (index == lessonSentencesAndWords_Arr.count - 1) // Ако последната част от изречение в края на текта нама препинателен знак.
            {
               sentencesConnectedParts_fromTheLesson_Arr.append(wholeSentence_Str)
               amount_sentenceParts += 1
               theSum_ofConnectedSentences_Arr.append(amount_sentenceParts)
            }
         }
         else {
            wholeSentence_Str += lessonSentencesAndWords_Arr[index]
            sentencesConnectedParts_fromTheLesson_Arr.append(wholeSentence_Str)
            amount_sentenceParts += 1
            theSum_ofConnectedSentences_Arr.append(amount_sentenceParts)
            
            wholeSentence_Str = ""
            amount_sentenceParts = 0
         }
         index += 1
      }
   }
   func       Connect_TwoWholeSentencesFromLesson ()
   {
      //TO-DO
   }
   func       Color_FindAttributedText_CMD() -> Bool // Задаване на цвят с CMDs" 🌈
   {
      if(inputTextView_One.text.contains(   "@#.gray#")    	   // UIColor.gray
         || inputTextView_One.text.contains("@#.lightGray#")   // UIColor.lightGray
         || inputTextView_One.text.contains("@#.darkGray#")    // UIColor.darkGray
         || inputTextView_One.text.contains("@#.gray#")        // UIColor.gray
         || inputTextView_One.text.contains("@#.brown#")       // UIColor.brown
         || inputTextView_One.text.contains("@#.green#")       // UIColor.green
         || inputTextView_One.text.contains("@#.systemMint#")) // UIColor.systemMint
         || inputTextView_One.text.contains("@#.blue#")        // UIColor.blue
         || inputTextView_One.text.contains("@#.cyan#")        // UIColor.cyan
         || inputTextView_One.text.contains("@#.purple#")      // UIColor.purple
         || inputTextView_One.text.contains("@#.red#")         // UIColor.red
         || inputTextView_One.text.contains("@#.yellow#")      // UIColor.yellow
         || inputTextView_One.text.contains("@#.magenta#")     // UIColor.magenta
         || inputTextView_One.text.contains("@#.orange#")      // UIColor.orange
         || inputTextView_One.text.contains("@#.label#")       // UIColor.label
         || inputTextView_One.text.contains("@#.black#")       // UIColor.black
         || inputTextView_One.text.contains("@#.white#")       // UIColor.white
      {
         let fontColorARR_CMDs = inputTextView_One.text.components(separatedBy: "#")
         savedColor = fontColorARR_CMDs[1].replacingOccurrences(of: ".", with: "")
         
         // Конвертиране на стринг с името на цвета в UIColor
         let selectorColor = Selector("\(savedColor)Color")
         if UIColor.self.responds(to: selectorColor)
         {
            let color = UIColor.self.perform(selectorColor).takeUnretainedValue()
            fontColor = color as! UIColor
         }
         
         Color_SetToAttributedText(fontColor)
         return true
      }
      return false
   }
   func       Color_SetToAttributedText(_ textColor: UIColor) // Задаване на цвят " 🌈🔘🟡🔴🟣🔵🟢🟤
   {
      let colorFroSave = savedColor.replacingOccurrences(of: savedColor, with: "@#." + savedColor + "#")
      saveSettings_Dictionary.set(colorFroSave, forKey: "FontColor")
      
      learnLevelIndex_Label.textColor = fontColor
      menu_Btn.setTitleColor(fontColor, for: .normal)
      chooseLanguage_Btn.setTitleColor(fontColor, for: .normal)
      sentencesLength_Btn.setTitleColor(fontColor, for: .normal)
      edit_lessonsText_Btn.setTitleColor(fontColor, for: .normal)
      labelText_LearnL.textColor = fontColor
      
      inputTextView_One.textColor = fontColor
      inputTextView_Second.textColor = fontColor
      extracted_textView.textColor = fontColor
   }
   func       CompareGuessLetter(_ spokenLetter: UIButton, _ alphabetChar: UIButton)
   {
      if(spokenL == "..."){return}
      
      let guessedL = CreateAttributedString("\n Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n")
      extracted_textView.attributedText = guessedL
      extracted_textView.textColor = UIColor.label
      //extracted_textView.text += "\n Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n"
      
      if(spokenL == "") {spokenL = (spokenLetter.titleLabel?.text)!}
      else if(alphabetL == "")
      {
         alphabetL = (alphabetChar.titleLabel?.text)!
        
         //Compare letters
         if(spokenL == alphabetL)
         {
            let answer = CreateAttributedString(" Correct: \(spokenL)\n Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n")
            extracted_textView.attributedText = answer
            extracted_textView.textColor = #colorLiteral(red: 0.1100478843, green: 0.6531985402, blue: 0.0890718326, alpha: 1)  //UIColor(red: 100, green: 100, blue: 100, alpha: 1)
            //extracted_textView.text = "Correct: \(spokenL)\n"
            //extracted_textView.text += "Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n"
            
            //Show count of guessed letters and reset statistic
            guessedLettersCount += 1
            ReachedNumbersOfGuessedLetters()
            spokenL = ""
            alphabetL = ""
         }
         else {
            let answer = CreateAttributedString("\n Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n")
            extracted_textView.attributedText = answer
            extracted_textView.textColor = UIColor.red
            
            alphabetL = ""
            guessedLettersCount = 0
            reachTheNumberOfGuessedLetters = 10
            //extracted_textView.text = "\n"
            //extracted_textView.text += "Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n"
         }
      }
   }
   func       CreateAttributedString(_ stringToAttribute: String) -> NSMutableAttributedString
   {
      let attributedStr = NSMutableAttributedString(string: stringToAttribute)
      attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor , range: NSMakeRange(0, attributedStr.length))
      attributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontName, size: index_textSize) as Any, range: NSMakeRange(0, attributedStr.length))
      
      return attributedStr
   }
   ///D-----------↓
   func       Delete_LessonsFiles() // ❌ 📙 🗑
   {
      //Взима всички фаилове с уроци и ги прави на бутони за избиране-изтриване. После влиза в метод за изтриване
      guard let filesDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first  else { return }
      do {
         var lessonFileNameForDelete = ""
         
         var listOfFiles = try FileManager.default.contentsOfDirectory(at: filesDirectory, includingPropertiesForKeys: nil, options: [])
         //Сортиране на файловете
         listOfFiles = listOfFiles.sorted { fileA, fileB in
            return fileA.lastPathComponent .localizedStandardCompare(fileB.lastPathComponent) == ComparisonResult.orderedAscending }
         
         let deleteLessonsFiles_Alert = UIAlertController(title:"Delete lesson!", message: "Number of lessons: \(listOfFiles.count)", preferredStyle: .actionSheet)
         
         for fileLesson in listOfFiles
         {
            if(fileLesson.lastPathComponent.contains(selectedLanguage_Str)
               || fileLesson.lastPathComponent.contains(".DS_Store")
               || fileLesson.lastPathComponent.contains(".tmp"))
            {
               var fileLessonName = fileLesson.lastPathComponent.replacingOccurrences(of: ".txt", with: "")
               fileLessonName = fileLessonName.replacingOccurrences(of: selectedLanguage_Str + lesson_forLearning_Str, with: "")
               fileLessonName = fileLessonName.replacingOccurrences(of: "[", with: "")
               fileLessonName = fileLessonName.replacingOccurrences(of: "]", with: "")
               
               let deleteLessonsFiles_Action = UIAlertAction(title: "❌  \(fileLessonName)", style: .default, handler:{
                  [self]ACTION in
                  lessonFileNameForDelete = "\(fileLesson.lastPathComponent)"//Взима името на файла за триене
                  
                  let deleteThisFileLesson_Alert = UIAlertController(title: "🚮  Delete this file?", message: "\"\(fileLessonName)\"", preferredStyle: .alert)
                  deleteThisFileLesson_Alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler:{
                     // 👍🏻  👎🏻
                     [self]ACTION in
                     Delete_SelectedLessonFile(lessonFileNameForDelete)
                     Delete_LessonsFiles() }))  //Влиза отново в метода за триене за ново изтриване
                  deleteThisFileLesson_Alert.addAction(UIAlertAction(title: "No", style: .default, handler:{ [self]ACTION in Delete_LessonsFiles() }))
                  present(deleteThisFileLesson_Alert, animated: true, completion: nil)
               })
               deleteLessonsFiles_Action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
               //----------------------------------------------------
               deleteLessonsFiles_Alert.addAction(deleteLessonsFiles_Action)
            }
         }
         deleteLessonsFiles_Alert.addAction(UIAlertAction(title: "↩️ Back", style: .cancel, handler: { [self]ACTION in
            Menu_Btn((Any).self)
            if(lessonFileName == lessonFileNameForDelete && lessonFileName != ""){ ClearTextField_Btn(() as Any) }})
         )
         present(deleteLessonsFiles_Alert, animated: true, completion: nil)
      }
      catch{}
   }
   @objc func DismissOnTapOutside_UIAlert()
   {
      self.dismiss(animated: true, completion: nil)
      isMenuShow = false
   }
   func       Download_theTranslatedTextFile(_ url: URL) // ⏬ 📲 ⤵️ 📥
   {
      var theFileNameWithTranslation = ""
      
      let config = URLSessionConfiguration.default
      config.waitsForConnectivity = false
      
      URLSession(configuration: config).downloadTask(with: url) { data, response, error in
         guard let fileURL = data else
         {
            self.timer_seeTranslationAnimateClock.invalidate()
            return
         }
         do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
            try FileManager.default.moveItem(at: fileURL, to: savedURL)
            
            theFileNameWithTranslation = fileURL.lastPathComponent
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.Get_theTranslatedText(theFileNameWithTranslation) }
         }
         catch {
            self.extracted_textView.text += "Download translation file error: \(error)"
         }
      }.resume()
   }
   func       Delete_LearnedWords_Keys_UserDefaults_Dictionary() // ❌
   {
      //-----------------------------------------------------------
      ///Изтрива всички ключове. За ТЕСТВАНЕ E.
      //for (key, _) in saveSettings_Dictionary.dictionaryRepresentation()
      //{
      //   saveSettings_Dictionary.removeObject(forKey: key)
      //}
      //-----------------------------------------------------------
      
      for (key, value) in count_LearnedWords_Dictionary.dictionaryRepresentation()
      {
         if(value is String)
         {
            let wordValue = value as! String
            
            if(wordValue == "LEARNED_" + selectedLanguage_Str + words_forLearning_Str)
            {
               count_LearnedWords_Dictionary.removeObject(forKey: key)
            }
         }
      }
   }
   func       Delete_SelectedLessonFile(_ lessonFileNameForDelete: String) // ❌ 📙 🗑
   {
      ///Изтрива всички ключове. За ТЕСТВАНЕ E.
      //for (key, _) in saveSettings_Dictionary.dictionaryRepresentation()
      //{
      //   saveSettings_Dictionary.removeObject(forKey: key)
      //}
      //-------------------------------
      //		for key in saveSettings_Dictionary.dictionaryRepresentation().keys // Изтриване на ключ който започва с някаква дума. За ТЕСТВАНЕ E.
      //		{
      //			if(key.hasPrefix("FontColor"))
      //			{
      //				saveSettings_Dictionary.removeObject(forKey: key)
      //			}
      //		}
      //		let keysValues = saveSettings_Dictionary.dictionaryRepresentation().values //Масив с key и values за преглед в текстов файл
      //-------------------------------
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         let fileManager = FileManager.default
         let fileURL = dir.appendingPathComponent(lessonFileNameForDelete)
         
         do {   //Deleting key and value from the dictionary and file from the directory
            saveSettings_Dictionary.removeObject(forKey: lessonFileNameForDelete)
            try fileManager.removeItem(at: fileURL)
         } catch {}
      }
      
      let isLastOpenedFile = saveSettings_Dictionary.string(forKey: selectedLanguage_Str + lastOpenedFile_str)
      
      if(lessonFileNameForDelete == isLastOpenedFile)
      {
         saveSettings_Dictionary.removeObject(forKey: selectedLanguage_Str + lastOpenedFile_str)
      }
      if(lessonFileName == lessonFileNameForDelete)
      {
         isSavedWords = false
         index_sentencePos = -1
         extracted_textView.text = nil
         iKnowThisWord_btn.isHidden = true
         lessonSentencesAndWords_Arr = [String]()
         sentenceOrWord_AfterShowingAllText = ""
         lessonName_Label.text = "\"Lesson name\""
         sentencesConnectedParts_fromTheLesson_Arr = [String]()
         sentenceProgressIndex_Start.setTitle("\(0)", for: .normal)
         sentenceProgressIndex_End.setTitle("\(0)", for: .normal)
         progressBar.setProgress(0, animated: true)
         sentenceProgressIndex_Start.backgroundColor = UIColor.systemGray3
         sentenceProgressIndex_End.backgroundColor = UIColor.systemGray3
         
         Timer_HideAllLessonTextAndField()
      }
   }
   func       Delete_TheTranslatedTextFile(_ lessonFileNameForDelete: String)
   {
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         let fileManager = FileManager.default
         let fileURL = dir.appendingPathComponent(lessonFileNameForDelete)
         
         do {
            try fileManager.removeItem(at: fileURL)
         }
         catch {}
      }
   }
   ///E-----------↓
   @objc func Extract_TranslatedText() // + 📍 📎 🔄 📌
   {
      Shadow_Buttons(seeTranslation_Btn!)
      
      //  (\\|\"|\s|“)[а-яА-Я0-9\n\s\\\-\!\,\.\?\:\;\"\(\)„“]+(\,|\.|\s|\"|“|\\)                   |--> 1. почти работи
      //  (\\|\"|\s|“)[а-яА-Я0-9a-zA-Z\n\s\\\-\!\,\.\?\:\;\\'"\(\)„“]+(\.|\s|\"|“|\\)(?:,[^null])  |--> 2. по-добре работи
      var translatedClearedText = ""
      let pattern: String = #"(\\|\"|\s|“)[а-яА-Я0-9a-zA-ZßåäöüÜÖ\n\s\\\-\\è\\é\!\/\%\,\.\?\:\;\\'"\(\)„“”–—…»]+(\.|\s|\"|“|\\)(?:,")"#
      //                      (\\|\"|\s|“)[а-яА-Я0-9a-zA-ZßåäöüÜÖ\n\s\\\-\!\,\.\?\:\;\\'"\(\)„“”–—…»]+(\.|\s|\"|“|\\)(?:,"[^null]) Två bastanta jättekvinnor kom in i grottan,
      //                      (\\|\"|\s|“)[а-яА-Я0-9a-zA-ZßåäöüÜÖ\n\s\\\-\!\,\.\?\:\;\\'"\(\)„“”–—…»]+(\.|\s|\"|“)(?:,")
      let NSString = NSString(string: sentenceOrWord_translatedText)
      let regex = try! NSRegularExpression(pattern: pattern, options: [])
      let results = regex.matches(in: sentenceOrWord_translatedText, options: [], range: NSRange(location: 0, length: NSString.length))
      var resultsArr = results.map { NSString.substring(with: $0.range) }
      
      if(resultsArr.count > 0)
      {
         for index in 0...resultsArr.count - 1
         {
            if(resultsArr[index] != "\",\"" && resultsArr[index] != "\\\"\\")
            {
               resultsArr[index].removeFirst(1)
               translatedClearedText += resultsArr[index]
            }}
      }
      else { extracted_textView.text = "😧😨😱 \nRegex error!"; return }
      
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "41042ad53247f54a3e573a8c87482365", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "1fdac2347d4ad2bfc63cca9b4fbecbbb", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "2e8de74564aec87fb81cb0340a661858", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "1eb561d2d816b8957a38cd5018eb164c", with: "")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "ad3d68f0fc47c8c7a84213b3d785dc3a", with: "")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "8965740e25c5159704771322c83775d6", with: "")
		if(isSomeWord_Pressed == true){
         translatedClearedText = translatedClearedText.replacingOccurrences(of: ".", with: "") }
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\n", with: "㉷")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\\"", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "\",\"", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: ",\"", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: ",\n", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: " .", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: ";", with: "")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\u200b", with: "")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\u003d", with: "=")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\u0026", with: "&")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\u003e", with: ">")
		translatedClearedText = translatedClearedText.replacingOccurrences(of: "\\u003c", with: "<")
      translatedClearedText = translatedClearedText.replacingOccurrences(of: "㉷", with: "\n")
      
      if(translatedClearedText == "") { extracted_textView.text = "!!!" }
      else  {
         let tappableTrnslText = CreateAttributedString(translatedClearedText)
         sentenceOrWord_translatedText = translatedClearedText // Показване на превода след спиране на говоренето
         
         if(isSomeWord_Pressed == true || isSavedWords == true)
         {
            let tappableText = CreateAttributedString("📌 " + someTouchedWord + "\n")
            tappableText.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, tappableText.length))
            
            let regularText = NSMutableAttributedString(string: "")
            regularText.append(tappableText)
            regularText.append(tappableTrnslText)
            
            extracted_textView.attributedText = regularText
            isSomeWord_Pressed = false
         }
         else if(isSeeTranslBtn_pressed == true) {
            extracted_textView.attributedText = tappableTrnslText
            isSeeTranslBtn_pressed = false
         }
      }
      extracted_textView.isHidden = false
   }
	@IBAction func Edit_lessonText_Btn(_ sender: Any)
	{
		///Показва и скрива целия текс на настоящия урок

		Shadow_Buttons(edit_lessonsText_Btn!)
		timer_showHide_AllLessonsText.invalidate()

		if(alphabetShowHide_isShow == true) { return }

		if(alphabetShowHide_isShow == true)
		{
			guessTheLetter_Btn.isHidden = true
			view.willRemoveSubview(guessTheLetter_Btn)
			alphabetShowHide_isShow = false
			Remove_AlphabetBtnsFromView()
		}

		if(isAllLessonText == false)
		{
			posX_object =  -view.frame.width * 1.0666 //view.subviews
			posY_object =   view.frame.height / 6.3
			width_object =  view.frame.width  / 1.125
			height_object = view.frame.height / 1.3
			inputTextView_Second.frame = inputTextView_One.frame
			inputTextView_One.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)

			isAllLessonText = true
			tapGesture.isEnabled = false
			iKnowThisWord_btn.isHidden = true
			inputTextView_Second.isHidden = false
			background_ITV_One_showAllText.isHidden = false
			next_prev_words_PanGesture.isEnabled = false
			background_ITV_One_showAllText.backgroundColor = UIColor.secondarySystemGroupedBackground
			background_ITV_One_showAllText.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)

			BtnsBorder(background_ITV_One_showAllText!)
			Shadow_BorderAndAllLessonText(background_ITV_One_showAllText!)

			inputTextView_Second.text = inputTextView_One.text
			sentenceOrWord_AfterShowingAllText = inputTextView_One.text
			inputTextView_One.text = Read_SelectedLessonFile(lessonFileName)

			if(isKeyboardOn == true) { KeyboardWillShow() }

			timer_showHide_AllLessonsText = Timer.scheduledTimer(timeInterval: 0.0005, target: self, selector: #selector(Show_AllLessonText_FieldAnimate), userInfo: nil, repeats: true)
			//inputTextView_Second.frame = CGRect.init(x: view.frame.width / 75, y: view.frame.height / 6.766,  width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
		}
		else {
			setTextTo_ITV_One = true
			Timer_HideAllLessonTextAndField()
		}
	}
	///F-----------↓
   func       FindPosition_WhenChangeTheLessonLevel (_ theSum_ofConnectedSentences_Arr: [Int])
   {
      var summedPositions = 0
      
      for index in 0...theSum_ofConnectedSentences_Arr.count - 1
      {
         summedPositions += theSum_ofConnectedSentences_Arr[index] // Сумиране на долепените до настоящата позициа изречения и намиране на позицията
         
         if(summedPositions > theSum_ofAllConnectedSentences - lastSentenceSumPos) // Позицията на която е стигнал "index" значи, че сумата от долепените изречения е равна на сумата от изреченията в началния масив
         {
            theSum_ofAllConnectedSentences = summedPositions // Моментно задаване на сумата на свързаните изрч. Не се запаметява и може да се сменя нивото.
            index_sentencePos = index
            return
         }
      }
   }
   func       fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController)
   {
      // Attempt to read the selected font descriptor, but exit quietly if that fails
      guard let descriptor = viewController.selectedFontDescriptor else { return }
      
      let font = UIFont(descriptor: descriptor, size: index_textSize)
      inputTextView_One.font = font
      inputTextView_Second.font = font
      extracted_textView.font = font
      
      fontName = font.fontName
      saveSettings_Dictionary.set(font.fontName, forKey: "Font_Name")
      
      isMenuShow = false
      HideKeyboard()
   }
   ///G-----------↓
   func       Get_SentenceIndex()
   {
      let getSettingsStr = saveSettings_Dictionary.string(forKey: lessonFileName)
      
      if(getSettingsStr != nil)
      {
         let getSettingsArr = getSettingsStr!.components(separatedBy: " ")
         index_sentencePos = Int(getSettingsArr[0])!
         theSum_ofAllConnectedSentences = Int(getSettingsArr[1])!
      }
      else if(getSettingsStr == nil) // Ако урока все още не е отварян и сумата и индекса може да останат от предния урок
      {
         index_sentencePos = 0
         theSum_ofAllConnectedSentences = 0
      }
   }
   func       Get_LearnedWords_Count() -> Int
   {
      var count_learnedWords = 0
      let count_learnedWords_DictionaryARR = count_LearnedWords_Dictionary.dictionaryRepresentation()
      let learned_wordForLearning = "LEARNED_" + selectedLanguage_Str + words_forLearning_Str.replacingOccurrences(of: ".txt", with: "")
      
      // Extract the words from the Dictionary into string Array
      for (_, value) in count_learnedWords_DictionaryARR
      {
         let keyValueObj = (value as AnyObject)
         
         if(keyValueObj is String)
         {
            let keyValueStr = keyValueObj as! String
            
            if(keyValueStr == learned_wordForLearning) // Count the words when the learned markers are equal
            {
               count_learnedWords += 1
            }
         }
      }
      
      return count_learnedWords
   }
   @objc func GuessSpokenLetter(_ alphabetChar: UIButton)
   {
      Speak_AlphabetLetter(alphabetChar)
      
      if !(spokenL == ""){
         let compareButton: UIButton = UIButton()
         CompareGuessLetter(compareButton, alphabetChar)}
   }

   @objc func GoogleTranslate(_ textOrWord_forTranslate: String)
   {
      let textOrWord_forTranslate = textOrWord_forTranslate.replacingOccurrences(of: "\"", with: "'")
      let encodedURL = textOrWord_forTranslate.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
      
      if(googleTransURL_Str != "" && textOrWord_forTranslate != "" && textOrWord_forTranslate != "%20")
      {
         //Превод чрез google translate
         let url: URL
         let defaultURL: URL = URL(string: googleTransURL_Str)!
         
         url = URL(string: googleTransURL_Str + encodedURL!) ?? defaultURL
         Download_theTranslatedTextFile(url) // Превеждане с "URLSession.shared.downloadTask(with: url)"
      }
      else {
         extracted_textView.text = "😎🧐 Oops\nChoose a language."
         ActivityClock_Translation_Done()
      }
      //---------------- От този линк се сваля json.txt файл с преведения текст -----------------------
      //let GoogleUrl = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=" + selected_language + "&tl=" + target_language + "&dt=t&dt=t&q=" + YourString
   }
   func       Get_LearnedLessonMarker(_ lessonFile: String) -> String
   {
      var learnedLessonMarker = ""
      let getSettingsStr = saveSettings_Dictionary.string(forKey: lessonFile)
      
      if(getSettingsStr != nil)
      {
         let getSettingsArr = getSettingsStr!.components(separatedBy: " ")
         learnedLessonMarker = getSettingsArr[getSettingsArr.count - 1]
      }
      return learnedLessonMarker
   }
   @objc func Get_theTranslatedText(_ theFileNameWithTranslation: String)
   {
      sentenceOrWord_translatedText = Read_SelectedLessonFile(theFileNameWithTranslation)
      Extract_TranslatedText()
      Delete_TheTranslatedTextFile(theFileNameWithTranslation)
      ActivityClock_Translation_Done()
   }
   func       Gesture_tapOnTextView(_ tapGesture: UITapGestureRecognizer) ///Original method
   {
      //		let point = tapGesture.location(in: inputTextView_One)
      //		if let detectedWord = GetWordAtPosition(point)
      //		{
      //			//----------------------------------
      //			//     .......Моя код тук.......
      //			//----------------------------------
      //		}
   }
   ///H-----------↓
   @objc func HideKeyboard()
	{
		view.endEditing(true) //Скриване на клавиаурата при натискане отстрани
	}
   @objc func Hide_AllLessonTextAndField()
   {
      //Променливи за ефекта на плъзгане от ляво на дясно на полето "inputTextView_One"
      
      Set_InputTextFrame_WhenLoadLesson_Position(0.6)
      
      if(posX_object - 4.5 > view.frame.width) //Часовник за плъзгане надясно на полето "inputTextView_One"
      {
         InputTextView_DefaulColorAndState()  //Задаване на стартова позиция на "inputTextView_One" полетo
         
         if(edit_lessonsText_Btn.isEnabled == false)
         {
            timer_showHide_AllLessonsText.invalidate()
            ChangeLanguage_ClearInputTV_One()
            if(alphabetShowHide_isShow == true) { ResetStatistic_ShowVocalLetters() }
            else { Timer_ShowStartText() }
         }
         else
         {
            if(lessonSentencesAndWords_Arr.count <= 0) { // Когато се изтрие в момента отворен урок
               inputTextView_One.text = ""
               Timer_ShowStartText()
            }
            else if(lessonSentencesAndWords_Arr.count >= 0) {
               setTextTo_ITV_One = true
               CreateSentence()
            }
            else {
               inputTextView_One.text = sentenceOrWord_AfterShowingAllText
               inputTextView_One.text = "" //MARK: --- TEST ---
               inputTextView_One.text = "Проверка дали трябва!!! Какво става ако го няма."
            }
            
            if(isSavedWords == true) { iKnowThisWord_btn.isHidden = false }
            
            ProgressBar_Progress()
            tapGesture.isEnabled = true
         }
      }
   }
   @objc func Hide_Image_AppEnterForeground()
   {
      // Скриване на стартовата снимка.
      UIView.transition(from: labelText_LearnL,    to: countryFlags_SwitchField2, duration: 1.0, options: .transitionCurlUp, completion: nil)
      UIView.transition(from: image_CFlags_LearnL, to: countryFlags_SwitchField1, duration: 1.0, options: .transitionCurlUp, completion:
									{ [self] _ in
			if(isMenuShow == true ) { Menu_Btn(AnyObject.self) } //За появяване на менюто след скриване на стартовата снимка

			if(inputTextView_One.text == "" && sentencesConnectedParts_fromTheLesson_Arr.count < 1){
				index_ShowStartTxt = 0
				inputTextView_One.text = ""
				timer_ShowStartText.invalidate()
				Timer_ShowStartText()
			}
		})
   }
   ///I-----------↓
   func       Info_Program()// ℹ️ Info Button
   {
      let alertMsg_Info: UIAlertController? = UIAlertController(title: "About: V5.6.2(new_5)", message: "\"Learn Language\" is a simple program, based on copy, pastе, listening and reading text. \nLast update on 3.2.2024\nPowered by Google translate.", preferredStyle: .alert)
      
      let learnedWords = UIAlertAction(title: "         🏫  Words: \(Get_LearnedWords_Count())", style: .default, handler: {
         [self] ACTION in
         if(isSavedWords == true)
         {                          ///Показване и записване във фаийл на нучените думи
            let learnedWords: UIAlertController? = UIAlertController(title: "Show learned words?", message: "Display and save learned words into a file.", preferredStyle: .alert)
            learnedWords!.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
               [self] ACTION in
               Info_LearnedWords()
               let deleteLearnedWords = UIAlertController(title: "🗑 Delete", message: "Reset learned word score and delete learned words?!", preferredStyle: .alert)
               deleteLearnedWords.addAction(UIAlertAction(title: "❌ Yes", style: .destructive, handler: { [self] ACTION in Delete_LearnedWords_Keys_UserDefaults_Dictionary() }))
               deleteLearnedWords.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
               isMenuShow = false
               present(deleteLearnedWords, animated: true, completion: nil)
            }))
            learnedWords!.addAction(UIAlertAction(title: "No", style: .default, handler: { [self] ACTION in isMenuShow = false }))
            present(learnedWords!, animated: true, completion: nil)
         }
         else { isMenuShow = false }})
      learnedWords.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      //----------
      let fontColors = UIAlertAction(title: "         🎨   Font color", style: .default, handler: {
         [self] Action in
         isMenuShow = false
         fontColor_Alert = UIAlertController(title: nil, message: "🎨  Select the text color", preferredStyle: .alert)
         //-------------------------------------
         let defColor = UIAlertAction(title: "                🔘  Default", style: .default, handler: { [self] Action in  fontColor = UIColor.label;  savedColor = "label";  Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let gryColor = UIAlertAction(title: "                ⚪️  Gray",    style: .default, handler: { [self] Action in  fontColor = UIColor.gray;   savedColor = "gray";   Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let yelColor = UIAlertAction(title: "                🟡  Yellow",  style: .default, handler: { [self] Action in  fontColor = UIColor.yellow; savedColor = "yellow"; Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let redColor = UIAlertAction(title: "                🔴  Red",     style: .default, handler: { [self] Action in  fontColor = UIColor.red;    savedColor = "red";    Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let purColor = UIAlertAction(title: "                🟣  Purple",  style: .default, handler: { [self] Action in  fontColor = UIColor.purple; savedColor = "purple"; Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let bluColor = UIAlertAction(title: "                🔵  Blue",    style: .default, handler: { [self] Action in  fontColor = UIColor.blue;   savedColor = "blue";   Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let grnColor = UIAlertAction(title: "                🟢  Green",   style: .default, handler: { [self] Action in  fontColor = UIColor.green;  savedColor = "green";  Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let brwColor = UIAlertAction(title: "                🟤  Brown",   style: .default, handler: { [self] Action in  fontColor = UIColor.brown;  savedColor = "brown";  Color_SetToAttributedText(fontColor);  Present_Method(fontColor_Alert);  /*isMenuShow = false*/ })
         let colorsCMD = UIAlertAction(title: "               🌈  List of CMDs", style: .default, handler: {
            [self] Action in
            if(isAllLessonText == false) { Edit_lessonText_Btn(() as Any) }
            tapGesture.isEnabled = false
            inputTextView_One.becomeFirstResponder()
            inputTextView_One.text =
              "        @#.label#\n"
            + "        @#.white#\n"
            + "        @#.lightGray#\n"
            + "        @#.gray#\n"
            + "        @#.darkGray#\n"
            + "        @#.green#\n"
            + "        @#.systemMint#\n"
            + "        @#.blue#\n"
            + "        @#.cyan#\n"
            + "        @#.red#\n"
            + "        @#.yellow#\n"
            + "        @#.magenta#\n"
            + "        @#.orange#\n"
            + "        @#.purple#\n"
            + "        @#.brown#\n"
            + "        @#.black#"
         })
         //			let closeBtn = UIAlertAction(title: "Close",style: .cancel, handler: { [self] ACTION in /*isMenuShow = false*/ })
         
         defColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         gryColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         redColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         bluColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         brwColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         purColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         yelColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         grnColor.setValue(CATextLayerAlignmentMode.left,  forKey: "titleTextAlignment")
         colorsCMD.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
         //-------------------------------------
         fontColor_Alert.addAction(defColor)
         fontColor_Alert.addAction(gryColor)
         fontColor_Alert.addAction(yelColor)
         fontColor_Alert.addAction(redColor)
         fontColor_Alert.addAction(purColor)
         fontColor_Alert.addAction(bluColor)
         fontColor_Alert.addAction(grnColor)
         fontColor_Alert.addAction(brwColor)
         //fontColor_Alert.addAction(closeBtn)
         if(edit_lessonsText_Btn.isEnabled == true) { fontColor_Alert.addAction(colorsCMD) }
         Present_Method(fontColor_Alert)
      })
      fontColors.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
         //----------
      let fontsNames = UIAlertAction(title: "         🈯️   Font name", style: .default, handler: {
         [self] ACTION in
         
         let configuration = UIFontPickerViewController.Configuration()
         configuration.includeFaces = true
         
         let fontPicker = UIFontPickerViewController(configuration: configuration)
         fontPicker.delegate = self
         present(fontPicker, animated: true)
      })
      fontsNames.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
         //----------
      let info_savedKeysValuePairs = UIAlertAction(title: "         🔑   Keys/Values", style: .default, handler: {
         [self] ACTION in Info_SavedKeysValues()
      })
      info_savedKeysValuePairs.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
      
      let close_Btn = UIAlertAction(title: "Close",style: .cancel, handler: { [self] ACTION in isMenuShow = false } )
      //------------------------------------------------------
      alertMsg_Info!.addAction(learnedWords)
      alertMsg_Info?.addAction(fontColors)
      alertMsg_Info?.addAction(fontsNames)
      alertMsg_Info?.addAction(info_savedKeysValuePairs)
      alertMsg_Info!.addAction(close_Btn)
      alertMsg_Info?.view.tintColor = UIColor.label
      Present_Method(alertMsg_Info!)
   }
   func       Info_LearnedWords() // "Save LEARNED_ Words"
   {
      /// Метода записва науените думи във файл
      var learnedWords_Strings = ""
      var learnedWords_Arr = [String]()
      let learnedWords_Dictionary = UserDefaults.standard.dictionaryRepresentation()
      let learnedWord = "LEARNED_" + selectedLanguage_Str + words_forLearning_Str
      
      // Extract the words from the Dictionary into string Array
      for (key, value) in learnedWords_Dictionary
      {
         let keyValueObj = (value as AnyObject) // Думата е ключ, защото е винаги различна
         
         if(keyValueObj is String)
         {
            let keyValueStr = keyValueObj as! String
            
            if(keyValueStr == learnedWord) {
               learnedWords_Arr.append("\(key)\n") // Думата е ключ, защото е винаги различна
            }
         }
      }
      
      if(learnedWords_Arr.count < 1) { return }
      
      //Sorting and converting to string to write into lesson file
      learnedWords_Arr.sort()
      for index in 0...learnedWords_Arr.count - 1
      {
         learnedWords_Strings += "\(learnedWords_Arr[index])"
      }
      
      //Write learned words into a file
      lessonFileName = "LEARNED_" + selectedLanguage_Str + words_forLearning_Str + ".txt"
      WriteText_IntoFIle(learnedWords_Strings)
   }
   func       Info_SavedKeysValues() // "Save LEARNED_ Words"
   {
         /// Метода записва науените думи във файл
      var learnedWords_Strings = ""
      var savedKeysValues_Arr = [String]()
      let learnedWords_Dictionary = UserDefaults.standard.dictionaryRepresentation()
      var indexWordOrLesson = 0
      
         // Extract the words from the Dictionary into string Array
      for (key, value) in learnedWords_Dictionary
      {
         let keyValueObj = (value as AnyObject) // Думата е ключ, защото е винаги различна
         
         if(keyValueObj is String)
         {
            savedKeysValues_Arr.append("\(key)\n") // Думата е ключ, защото е винаги различна
         }
      }
      
         //Sorting and converting to string to write into lesson file
      savedKeysValues_Arr.sort()
      for index in 0...savedKeysValues_Arr.count - 1
      {
         indexWordOrLesson += 1
         learnedWords_Strings += "\(indexWordOrLesson). \(savedKeysValues_Arr[index])"
      }
      inputTextView_One.text = learnedWords_Strings
   }
   @objc func InputTextView_LeftSliding()
   {
      InputTextView_OneAndSecond_LR_Sliding(-distSlide)
      //-------------------------------
      
      if(isITV_OneX_notInScreen == true && inputTextView_One.frame.minX <= view.frame.width  / 75)
      {
         let posXleft_ViewSecond = view.frame.width * 1.0133
         inputTextView_Second.frame = CGRect.init(x: posXleft_ViewSecond, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
         
         if (index_sentencePos < sentencesConnectedParts_fromTheLesson_Arr.count - 1) {
            index_sentencePos += 1
            if(isSavedWords == false) {
               theSum_ofAllConnectedSentences += theSum_ofConnectedSentences_Arr[index_sentencePos]
            }
            NextSentence_Method()
         }
         else {
            isNoPrev_NextText = true
            inputTextView_Second.text = "\n\n\n\n                🏁  END  🏁";       index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1
         }
         isITV_OneX_notInScreen = false
      }
      
      if(inputTextView_One.frame.minX <= -viewMaxX)
      {
         if(isNoPrev_NextText == false) {  //Стоп на часовник за плъзгане надясно на полето "inputTextView_One"
            InputTextView_PrevAndNextSentense_Default_After_Sliding()
         }
         else {
            // Плъзгане без пускане наляво и дясно
            viewMaxX = view.frame.width / 75
            index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1
            timer_SlidingInputTextView.invalidate()
            saveSettings_Dictionary.set("\(index_sentencePos) \(theSum_ofAllConnectedSentences) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
            timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: 0.0005, target: self, selector: #selector(InputTextView_noMoreNextText_Slide), userInfo: nil, repeats: true) }
      }
   }
   @objc func InputTextView_RightSliding()
   {
      InputTextView_OneAndSecond_LR_Sliding(distSlide)
      //-------------------------------
      
      if(isITV_OneX_notInScreen == true && inputTextView_One.frame.minX >= view.frame.width  / 75)
      {
         let posXRight_ViewSecond = -view.frame.width / 1.0133
         inputTextView_Second.frame = CGRect.init(x: posXRight_ViewSecond, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
         
         if (index_sentencePos > 1) {
            index_sentencePos -= 1
            if(isSavedWords == false) {
               theSum_ofAllConnectedSentences -= theSum_ofConnectedSentences_Arr[index_sentencePos]
            }
            PrevSentence_Method()
         }
         else {
            isNoPrev_NextText = true
            inputTextView_Second.text = "\n\n\n\n                🏁  START  🏁"
            index_sentencePos = 0
         }
         isITV_OneX_notInScreen = false
      }
      //-------------------------------
      
      if(inputTextView_One.frame.minX >= viewMaxX)
      {
         if(isNoPrev_NextText == false) { //Стоп на часовник за плъзгане надясно на полето "inputTextView_One"
            InputTextView_PrevAndNextSentense_Default_After_Sliding()
         }
         else {
            // Плъзгане без пускане наляво и дясно
            viewMaxX = view.frame.width / 75
            theSum_ofAllConnectedSentences = 0
            timer_SlidingInputTextView.invalidate()
            saveSettings_Dictionary.set("\(0) \(theSum_ofAllConnectedSentences) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
            timer_SlidingInputTextView = Timer.scheduledTimer(timeInterval: 0.0005, target: self, selector: #selector(InputTextView_noMorePrevText_Slide), userInfo: nil, repeats: true) }
      }
   }
   func       InputTextView_DefaulColorAndState()
   {
      //Тук трябват след показване на всичкия текст.          за модел см.от ръба
      posX_object =   view.frame.width  / 75       // (12 mini = 5)    ( 13 pro max = 6 )
      posY_object =   view.frame.height / 6.766    // (12 mini = 120)  ( 13 pro max = 128 )
      width_object =  view.frame.width  / 1.0869   // (12 mini = 345)  ( 13 pro max = 393 )
      height_object = view.frame.height / 2.7432   // (12 mini = 296)  ( 13 pro max = 342 )
      
      inputTextView_One.frame =  CGRect.init(x: posX_object, y: posY_object                 ,  width: width_object,                   height: height_object)
      extracted_textView.frame = CGRect.init(x: posX_object, y: extracted_textView.frame.minY, width: extracted_textView.frame.width, height: extracted_textView.frame.height)
      
      inputTextView_One.layer.cornerRadius = 0
      inputTextView_One.layer.borderWidth = 0
      inputTextView_Second.text = nil
      inputTextView_Second.isHidden = true
      next_prev_words_PanGesture.isEnabled = true
      timer_ShowStartText.invalidate()
      timer_showHide_AllLessonsText.invalidate()
      background_ITV_One_showAllText.isHidden = true
      
      if(isAllLessonText == false) {
         extracted_textView.isHidden = true
         extracted_textView.text = nil
      }
      isAllLessonText = false
      HideKeyboard()
   }
   @objc func InputTextView_noMorePrevText_Slide()
   {
      InputTextView_OneAndSecond_LR_Sliding(-distSlide)
      
      if(inputTextView_One.frame.minX <= viewMaxX)
      {
         index_sentencePos = 0
         InputTextView_OneAndSecond_LR_NoMoreText_DefaultState_After_Sliding() //Стоп на часовник за плъзгане на полето "inputTextView_One"
      }
   }
   @objc func InputTextView_noMoreNextText_Slide() //  ↩️ return or ↪️ next lesson
   {
      InputTextView_OneAndSecond_LR_Sliding(distSlide)
      
      if(inputTextView_One.frame.minX >= viewMaxX)
      {
         if(isSavedWords == true && iKnowThisWord_btn.isEnabled == false)
         {
            index_sentencePos -= 1
         }
         index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1
         ReturnThisLessonOrGoNext()
         InputTextView_OneAndSecond_LR_NoMoreText_DefaultState_After_Sliding()  //Стоп на часовник за плъзгане на полето "inputTextView_One"
      }
   }
   @objc func InputTextView_NotPassCenterScreen_forNext()
   {
      InputTextView_OneAndSecond_LR_Sliding(distSlide)
      
      if(inputTextView_One.frame.minX >= viewMaxX)
      {
         if(isSavedWords == false) {
            theSum_ofAllConnectedSentences -= theSum_ofConnectedSentences_Arr[index_sentencePos]
         }
         index_sentencePos -= 1
         InputTextView_NotPassCenterScreen_Default()
      }
   }
   @objc func InputTextView_NotPassCenterScreen_forPrev()
   {
      InputTextView_OneAndSecond_LR_Sliding(-distSlide)
      
      if(inputTextView_One.frame.minX <= viewMaxX)
      {
         index_sentencePos += 1
         if(isSavedWords == false) {
            theSum_ofAllConnectedSentences += theSum_ofConnectedSentences_Arr[index_sentencePos]
         }
         InputTextView_NotPassCenterScreen_Default()
      }
   }
   func       InputTextView_NotPassCenterScreen_Default()
   {
      isLeftSlideBegan = true
      isRightSlideBegan = true
      next_prev_words_PanGesture.isEnabled = true
      timer_SlidingInputTextView.invalidate()
      
      if(index_sentencePos < 0){ index_sentencePos = 0
         return
      }
      sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
      if(isSavedWords == false) {
         lastSentenceSumPos = theSum_ofConnectedSentences_Arr[index_sentencePos] }
   }
   func       InputTextView_OneAndSecond_LR_Sliding(_ dist: Double)
   {
      inputTextView_One.frame =    CGRect.init(x: inputTextView_One.frame.minX +    dist, y: inputTextView_One.frame.minY,    width: inputTextView_One.frame.width,    height: inputTextView_One.frame.height)
      inputTextView_Second.frame = CGRect.init(x: inputTextView_Second.frame.minX + dist, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
      extracted_textView.frame =   CGRect.init(x: extracted_textView.frame.minX +   dist, y: extracted_textView.frame.minY,   width: extracted_textView.frame.width,   height: extracted_textView.frame.height)
   }
   func       InputTextView_PrevAndNextSentense_Default_After_Sliding()
   {
      isLeftSlideBegan = true
      isRightSlideBegan = true
      tapGesture.isEnabled = true
      inputTextView_One.text = nil
      iKnowThisWord_btn.isEnabled = true
      timer_SlidingInputTextView.invalidate()
      next_prev_words_PanGesture.isEnabled = true
      isITV_One_becomeFirstRes = false
      saveSettings_Dictionary.set("\(index_sentencePos) \(theSum_ofAllConnectedSentences) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
      setTextTo_ITV_One = true
      CreateSentence()
      InputTextView_DefaulColorAndState()
      ProgressBar_Progress()
      
      if(isSpeak_savedWords == true && isSavedWords == true) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in Speaker() }
      }
   }
   func       InputTextView_OneAndSecond_LR_NoMoreText_DefaultState_After_Sliding()
   {
      isLeftSlideBegan = true
      isRightSlideBegan = true
      isNoPrev_NextText = false
      inputTextView_Second.text = nil
      timer_SlidingInputTextView.invalidate()
      next_prev_words_PanGesture.isEnabled = true
   }
	///K-----------↓
	@objc func KeyboardWillShow()
	{
		isKeyboardOn = true
		if(isAllLessonText == true)
		{
			height_object = (view.frame.height / 1.215) - keyboardHight       //Променя се като по-малък прозорец за показване на всичкия текст
			inputTextView_One.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
			background_ITV_One_showAllText.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)

			BtnsBorder(background_ITV_One_showAllText!)
			Shadow_BorderAndAllLessonText(background_ITV_One_showAllText!)
		}
	}
	@objc func KeyboardWillHide()
	{
		isKeyboardOn = false
		if(isAllLessonText == true)
		{
			height_object = view.frame.height / 1.3  //Променя се като по-голям прозорец за показване на всичкия текст
			inputTextView_One.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
			background_ITV_One_showAllText.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)

			BtnsBorder(background_ITV_One_showAllText!)
			Shadow_BorderAndAllLessonText(background_ITV_One_showAllText!)
		}
	}
	@objc func KeyboardWillShow_Height(notification: NSNotification)
	{
		//Взима размерите на клавиатурата
		if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			keyboardHight = keyboardRect.height
		}
	}
	///L-----------↓
   func       Load_SavedWordsToLearn()
   {
      isSavedWords = true
      alphabetShowHide_isShow = false
      Remove_AlphabetBtnsFromView()
      
      isMenuShow = false
      index_sentencePos = 0
      isAllLessonText = false
      sentenceLength_Level = 1
//      iKnowThisWord_btn.isEnabled = true
      edit_lessonsText_Btn.isEnabled = true
      lessonFileName = selectedLanguage_Str + words_forLearning_Str + ".txt"
      lessonName_Label.text = "\"" + "New words to learn" + "\""
      learnLevelIndex_Label.text = "\(sentenceLength_Level)"
      
      //"ReadSelected_LessonFile()" -> Връща "String" с целия текст от файла
      let readed_selectedLessonFile_Text = Read_SelectedLessonFile(lessonFileName).trimmingCharacters(in: .whitespacesAndNewlines)
      
      if(readed_selectedLessonFile_Text == "") // Когато са изтрити и научени всички думиза учене
      {
         inputTextView_One.text = "🕷🕸"
         index_sentencePos = -1
         ProgressBar_Progress()
         iKnowThisWord_btn.isHidden = true
         iKnowThisWord_btn.isEnabled = false
         lessonSentencesAndWords_Arr.removeAll()
         sentencesConnectedParts_fromTheLesson_Arr.removeAll()
         
         extracted_textView.attributedText = CreateAttributedString("😎🧐 Oops\nNothing here or choose a language.")
         return
      }
      lessonSentencesAndWords_Arr = readed_selectedLessonFile_Text.components(separatedBy: "\n")
      Get_SentenceIndex()
      sentencesConnectedParts_fromTheLesson_Arr = lessonSentencesAndWords_Arr
      sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
      
      Set_SentenceShowIndexColor(lessonFileName)
      PositionSet_HideSladingITV_Second()
      Set_InputTextFrame_WhenLoadLesson()
      Timer_HideAllLessonTextAndField()
   }
   func       Load_ListOfLessonsFiles()
   {
         ///Метода взима всички фаилове с уроци и ги прави на бутони за избиране. После влиза в метод за четене на текста на избрания файл
      view.willRemoveSubview(guessTheLetter_Btn)
      
      alphabetShowHide_isShow = false
      Remove_AlphabetBtnsFromView()
      
      guard let filesDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first  else { return }
      do {
         var listOfFiles = try FileManager.default.contentsOfDirectory(at: filesDirectory, includingPropertiesForKeys: nil, options: [])
         
         listOfFiles = listOfFiles.sorted  //Сортиране на файловете
         {
            fileA, fileB in return fileA.lastPathComponent.localizedStandardCompare(fileB.lastPathComponent) == ComparisonResult.orderedAscending
         }
         var lastOpenedFile = ""
         var lastOpenedFileMarkerChar = ""
         
         if((saveSettings_Dictionary.object(forKey: selectedLanguage_Str + lastOpenedFile_str)) != nil) { //Намиране на последно отваряния урок за да му сложи маркер
            lastOpenedFile = saveSettings_Dictionary.string(forKey: selectedLanguage_Str + lastOpenedFile_str)!
         }
         
         var countOfLessonFiles = 0
         for fileLesson in listOfFiles {   //Намира броя на уроците на съответния език
            if(fileLesson.lastPathComponent.contains(selectedLanguage_Str + lesson_forLearning_Str)) { countOfLessonFiles += 1 }
         }
         
         let fileLesson_Alert = UIAlertController(title: "Lessons", message: "Number of lessons: \(countOfLessonFiles)", preferredStyle: .actionSheet)
         
         for fileLesson in listOfFiles
         {
            if((fileLesson.lastPathComponent.contains(selectedLanguage_Str + lesson_forLearning_Str)  //Показва файлове с уроци на съответния език
                || fileLesson.lastPathComponent.contains("LEARNED_" + selectedLanguage_Str)) )          //Показва файла със запаметени, научени думи на съответния език
            {
               
                  //---------------------------------------------
                  //					let numberOne = fileLesson.lastPathComponent.components(separatedBy: " ")
                  //					let numberOne_str = numberOne[numberOne.count - 1].replacingOccurrences(of: ".txt", with: "")
                  //					let numberOne_int = Int(numberOne_str.replacingOccurrences(of: "🧬", with: ""))
                  //					//----------
                  //					if(numberOne_int == 1)
                  //					{
                  //---------------------------------------------
               
               let noLearnedMarkerSpaces = "     "
               var learnedLessonMarker_InLOAD:String = ""
               
               if(lastOpenedFile == fileLesson.lastPathComponent) {
                  lastOpenedFileMarkerChar = "➡️" }    //👉🏻 ► → ➔ ☞ ➡️
               else {
                  lastOpenedFileMarkerChar = noLearnedMarkerSpaces }
               
               if(Get_LearnedLessonMarker(fileLesson.lastPathComponent).contains(learnedLessonSymbol)) { learnedLessonMarker_InLOAD = learnedLessonSymbol }
               else { learnedLessonMarker_InLOAD = noLearnedMarkerSpaces }
               
               //---------------------------------------------------------
               let fileLessonName = ReplacingOccurrences_LessonFileName(fileLesson.lastPathComponent)
               
               let fileLesson_Action = UIAlertAction( title:"\(lastOpenedFileMarkerChar) \(learnedLessonMarker_InLOAD)\(fileLessonName)", style: .default, handler:{
                  [self]ACTION in
                  isMenuShow = false
                  isSavedWords = false
                  speaker_Btn.alpha = 1
                  isAllLessonText = false
                  setTextTo_ITV_One = true
                  isSeeTranslBtn_pressed = false
                  edit_lessonsText_Btn.isEnabled = true
                  lessonFileName = "\(fileLesson.lastPathComponent)"
                  learnedLessonMarker = Get_LearnedLessonMarker(fileLesson.lastPathComponent) // Задава маркера като за сегашния урок, защото ако отане същия като предния като мина на следващо изречение и променя маркера от прочетен наобратно и обратно
                  
                  if(fileLessonName.contains("LEARNED_")) {
                     lessonName_Label.text = ReplacingOccurrences_LessonFileName(lessonFileName)
                  }
                  else {
                     lessonName_Label.text = ReplacingOccurrences_LessonNameToLabel(lessonFileName)
                  }
                  
                  saveSettings_Dictionary.set("\(lessonFileName)", forKey: selectedLanguage_Str + lastOpenedFile_str)
                  var readed_selectedLessonFile_Text = Read_SelectedLessonFile(lessonFileName)
                  readed_selectedLessonFile_Text = readed_selectedLessonFile_Text.trimmingCharacters(in: .whitespacesAndNewlines)
                  
                  if(readed_selectedLessonFile_Text == "") { inputTextView_One.text = "empty";  return }
                  
                  SplitLessonTextIntoSentences(readed_selectedLessonFile_Text)
                  Get_SentenceIndex()
                  if(sentenceLength_Level == 1)      { Connect_OnePartOfSentence() }
                  else if(sentenceLength_Level == 2) { Connect_TwoPartsOfSentence() }
                  else if(sentenceLength_Level == 3) { Connect_WholeSentenceFromLesson() }
                  //else if(sentenceLength_Level == 4) { Get_TwoWholeSentencesFromLesson() }
                  
                  if(index_sentencePos > theSum_ofConnectedSentences_Arr.count - 1) {
                     lastSentenceSumPos = theSum_ofConnectedSentences_Arr[0]
                  }
                  else { lastSentenceSumPos = theSum_ofConnectedSentences_Arr[index_sentencePos] }
                  
                  if(saveSettings_Dictionary.object(forKey: lessonFileName) == nil) {
                     theSum_ofAllConnectedSentences = theSum_ofConnectedSentences_Arr[0]
                  }
                  FindPosition_WhenChangeTheLessonLevel(theSum_ofConnectedSentences_Arr)
                  if(index_sentencePos > sentencesConnectedParts_fromTheLesson_Arr.count) { index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1 }
                  sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
                  
                  Set_SentenceShowIndexColor(lessonFileName)
                  PositionSet_HideSladingITV_Second()
                  Set_InputTextFrame_WhenLoadLesson()
                  Timer_HideAllLessonTextAndField()
               })
               fileLesson_Action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
               //---------------------------------------------------------
               fileLesson_Alert.addAction(fileLesson_Action)
               //					}
               //					//----------
            }
         }
         fileLesson_Alert.addAction(UIAlertAction(title: "↩️ Back", style: .cancel, handler: { [self]ACTION in
            Menu_Btn((Any).self)
            if(sentencesConnectedParts_fromTheLesson_Arr.count < 1 && inputTextView_One.text == "") {
               Timer_ShowStartText()
            }}))
         fileLesson_Alert.view.tintColor = UIColor.label
         present(fileLesson_Alert, animated: true, completion: nil)
      }
      catch{}
   }
   func       Load_NextOrLastLesson(_ nextLessonName: String)
   {
      /// Показване на следващия урок в инфо бутона. Когато се натисне бутона със следващия урок той се зарежда и маркира като последно отварян
      if(nextLessonName == "No last lesson" || nextLessonName == "End lesson" ) {
         Load_ListOfLessonsFiles();   return
      }
      
      alphabetShowHide_isShow = false
      Remove_AlphabetBtnsFromView()
      
      isMenuShow = false
      index_sentencePos = 0
      
      if(nextLessonName.contains("LEARNED_")) {
         lessonFileName = "LEARNED_" + selectedLanguage_Str + words_forLearning_Str + ".txt"
         lessonName_Label.text = ReplacingOccurrences_LessonFileName(lessonFileName)
      }
      else {
         lessonFileName = nextLessonName.replacingOccurrences(of: "\"", with: "")
         lessonFileName = selectedLanguage_Str + lesson_forLearning_Str + lessonFileName + ".txt"
         lessonName_Label.text = ReplacingOccurrences_LessonNameToLabel(lessonFileName)
      }
      
      saveSettings_Dictionary.set("\(lessonFileName)", forKey: selectedLanguage_Str + lastOpenedFile_str)
      
      let readed_selectedLessonFile_Text = Read_SelectedLessonFile(lessonFileName)    //"ReadSelected_LessonFile()" -> Връща "String"
      
      SplitLessonTextIntoSentences(readed_selectedLessonFile_Text)
      Get_SentenceIndex()
           if(sentenceLength_Level == 1) { Connect_OnePartOfSentence() }
      else if(sentenceLength_Level == 2) { Connect_TwoPartsOfSentence() }
      else if(sentenceLength_Level == 3) { Connect_WholeSentenceFromLesson() }
      //else if(sentenceLength_Level == 4){ Get_TwoWholeSentencesFromLesson()
      
      if(index_sentencePos > theSum_ofConnectedSentences_Arr.count - 1) {
         lastSentenceSumPos = theSum_ofConnectedSentences_Arr[0]
      }
      else {
         if(index_sentencePos < 0) {
            inputTextView_One.text = "if(index_sentencePos < 0){ index_sentencePos < 0 } (за тест или да го оставя)"
            index_sentencePos = 0 } //MARK: Za Test
         lastSentenceSumPos = theSum_ofConnectedSentences_Arr[index_sentencePos]
      }
      
      FindPosition_WhenChangeTheLessonLevel(theSum_ofConnectedSentences_Arr)
      if(index_sentencePos > sentencesConnectedParts_fromTheLesson_Arr.count) { index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count - 1 }
      sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]  // Взима изречение на определената позиция
      learnedLessonMarker = Get_LearnedLessonMarker(lessonFileName) // Задава маркера като за сегашния урок. Иначе остава същия и променя маркера и за другите уроци
      
      isSavedWords = false
      speaker_Btn.alpha = 1
      isAllLessonText = false
      isSeeTranslBtn_pressed = false
      iKnowThisWord_btn.isHidden = true
      edit_lessonsText_Btn.isEnabled = true
      
      Set_SentenceShowIndexColor(lessonFileName)
      PositionSet_HideSladingITV_Second()
      Set_InputTextFrame_WhenLoadLesson()
      Timer_HideAllLessonTextAndField()
   }
   ///M-----------
   func       MonitorNetwork()
   {
      NETmonitor.pathUpdateHandler = { path in
         if path.status == .satisfied {
            DispatchQueue.main.async {
               [self] in
					lessonName_Label.textColor = UIColor.label
					if(lessonName_Label.text!.localizedStandardContains("⚠️")) {
						lessonName_Label.text?.removeFirst()}
               
               if(seeTranslation_Btn.currentImage != nil && isSomeWord_Pressed == true)
               {
                  Paste_TouchedWordToTextView(someTouchedWord)
               }
               else if(seeTranslation_Btn.currentImage != nil) { SeeTranslation() }
            }
         }
         else if path.status == .unsatisfied {
            DispatchQueue.main.async { [self] in
					lessonName_Label.textColor = UIColor.red
					if(lessonName_Label.text!.localizedStandardContains("⚠️") == false) {
						lessonName_Label.text = "⚠️" + lessonName_Label.text!}
            }
         }
      }
      let queue = DispatchQueue(label: "Network")
      NETmonitor.start(queue: queue)
   }
   func       MakeTouchedWordReadyToTranslate(_ touchedWord: String)
   {
      var someTouchedWord  = "\(touchedWord) \n"
      someTouchedWord += "\"\(touchedWord)\" \n"
      someTouchedWord += "\"\(touchedWord) .\""
      
      extracted_textView.isHidden = false
      GoogleTranslate(someTouchedWord)
      SeeTranslation_AnimatedClock()
   }
   func       MiddleBtnsSwapping_withFinger(_ panGesture: UIPanGestureRecognizer, _ btnThatMoves: UIButton)
   {
      ///Swap a button when it pass the center of another button
      let btnHalfWidth = speaker_Btn.frame.width / 10
      
      if(btnThatMoves.frame.minX > hideKeyboard_Btn.frame.minX               && btnThatMoves.frame.minX < hideKeyboard_Btn.frame.midX - btnHalfWidth         && btnThatMoves != hideKeyboard_Btn)
      {
         hideKeyboard_Btn.frame =           CGRect(x: btnThatMoves_PrevPosX, y: hideKeyboard_Btn.frame.minY,           width: hideKeyboard_Btn.frame.width,           height: hideKeyboard_Btn.frame.height)
         arrowUnderHideKeyboard_Btn.frame = CGRect(x: btnThatMoves_PrevPosX, y: arrowUnderHideKeyboard_Btn.frame.minY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height)
         btnThatMoves_PrevPosX = hideKeyboard_Btn.frame.minX - hideKeyboard_Btn.frame.width
      }
      else if(btnThatMoves.frame.minX > seeTranslation_Btn.frame.minX        && btnThatMoves.frame.minX < seeTranslation_Btn.frame.midX - btnHalfWidth        && btnThatMoves != seeTranslation_Btn)
      {
         seeTranslation_Btn.frame = CGRect(x: btnThatMoves_PrevPosX,        y: seeTranslation_Btn.frame.minY, width: seeTranslation_Btn.frame.width, height: seeTranslation_Btn.frame.height)
         btnThatMoves_PrevPosX = seeTranslation_Btn.frame.minX - seeTranslation_Btn.frame.width
      }
      else if(btnThatMoves.frame.minX > speaker_Btn.frame.minX               && btnThatMoves.frame.minX < speaker_Btn.frame.midX - btnHalfWidth               && btnThatMoves != speaker_Btn)
      {
         speaker_Btn.frame = CGRect(x: btnThatMoves_PrevPosX,               y: speaker_Btn.frame.minY, width: speaker_Btn.frame.width,                            height: speaker_Btn.frame.height)
         btnThatMoves_PrevPosX = speaker_Btn.frame.minX - speaker_Btn.frame.width
      }
      else if(btnThatMoves.frame.minX > copyText_forGoogleApp_Btn.frame.minX && btnThatMoves.frame.minX < copyText_forGoogleApp_Btn.frame.midX  - btnHalfWidth && btnThatMoves != copyText_forGoogleApp_Btn)
      {
         copyText_forGoogleApp_Btn.frame = CGRect(x: btnThatMoves_PrevPosX, y: copyText_forGoogleApp_Btn.frame.minY, width: copyText_forGoogleApp_Btn.frame.width, height: copyText_forGoogleApp_Btn.frame.height)
         btnThatMoves_PrevPosX = copyText_forGoogleApp_Btn.frame.minX - copyText_forGoogleApp_Btn.frame.width
      }
      //-------------------------------------------------------------------------------
      else if(btnThatMoves.frame.maxX > hideKeyboard_Btn.frame.midX + btnHalfWidth          && btnThatMoves.frame.maxX < hideKeyboard_Btn.frame.maxX          && btnThatMoves != hideKeyboard_Btn)
      {
         hideKeyboard_Btn.frame =           CGRect(x: btnThatMoves_PrevPosX, y: hideKeyboard_Btn.frame.minY,           width: hideKeyboard_Btn.frame.width,           height: hideKeyboard_Btn.frame.height)
         arrowUnderHideKeyboard_Btn.frame = CGRect(x: btnThatMoves_PrevPosX, y: arrowUnderHideKeyboard_Btn.frame.minY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height)
         btnThatMoves_PrevPosX = hideKeyboard_Btn.frame.maxX
      }
      else if(btnThatMoves.frame.maxX > seeTranslation_Btn.frame.midX + btnHalfWidth        && btnThatMoves.frame.maxX < seeTranslation_Btn.frame.maxX        && btnThatMoves != seeTranslation_Btn)
      {
         seeTranslation_Btn.frame =        CGRect(x: btnThatMoves_PrevPosX, y: seeTranslation_Btn.frame.minY, width: seeTranslation_Btn.frame.width,                  height: seeTranslation_Btn.frame.height)
         btnThatMoves_PrevPosX = seeTranslation_Btn.frame.maxX
      }
      else if(btnThatMoves.frame.maxX > speaker_Btn.frame.midX + btnHalfWidth               && btnThatMoves.frame.maxX < speaker_Btn.frame.maxX               && btnThatMoves != speaker_Btn)
      {
         speaker_Btn.frame =               CGRect(x: btnThatMoves_PrevPosX, y: speaker_Btn.frame.minY, width: speaker_Btn.frame.width,                                height: speaker_Btn.frame.height)
         btnThatMoves_PrevPosX = speaker_Btn.frame.maxX
      }
      else if(btnThatMoves.frame.maxX > copyText_forGoogleApp_Btn.frame.midX + btnHalfWidth && btnThatMoves.frame.maxX < copyText_forGoogleApp_Btn.frame.maxX && btnThatMoves != copyText_forGoogleApp_Btn)
      {
         copyText_forGoogleApp_Btn.frame = CGRect(x: btnThatMoves_PrevPosX, y: copyText_forGoogleApp_Btn.frame.minY, width: copyText_forGoogleApp_Btn.frame.width,    height: copyText_forGoogleApp_Btn.frame.height)
         btnThatMoves_PrevPosX = copyText_forGoogleApp_Btn.frame.maxX
      }
      
      if(panGesture.state == .ended)
      {
         // Call auto moving and return buttons Method after the gesture is ended and when is not pass the center of another button
         if(btnThatMoves.frame.minX > hideKeyboard_Btn.frame.minX          && btnThatMoves.frame.minX < hideKeyboard_Btn.frame.maxX          && btnThatMoves != hideKeyboard_Btn
            ||
            btnThatMoves.frame.minX > seeTranslation_Btn.frame.minX        && btnThatMoves.frame.minX < seeTranslation_Btn.frame.maxX        && btnThatMoves != seeTranslation_Btn
            ||
            btnThatMoves.frame.minX > speaker_Btn.frame.minX               && btnThatMoves.frame.minX < speaker_Btn.frame.maxX               && btnThatMoves != speaker_Btn
            ||
            btnThatMoves.frame.minX > copyText_forGoogleApp_Btn.frame.minX && btnThatMoves.frame.minX < copyText_forGoogleApp_Btn.frame.maxX && btnThatMoves != copyText_forGoogleApp_Btn
            ||
            btnThatMoves.frame.minX < btnThatMoves_PrevPosX)
         {
            Timer_Return_MiddleBtnsToCorrectPos_Right(btnThatMoves)
         }
         else if(btnThatMoves.frame.maxX > hideKeyboard_Btn.frame.minX          && btnThatMoves.frame.maxX < hideKeyboard_Btn.frame.maxX          && btnThatMoves != hideKeyboard_Btn
                 ||
                 btnThatMoves.frame.maxX > seeTranslation_Btn.frame.minX        && btnThatMoves.frame.maxX < seeTranslation_Btn.frame.maxX        && btnThatMoves != seeTranslation_Btn
                 ||
                 btnThatMoves.frame.maxX > speaker_Btn.frame.minX               && btnThatMoves.frame.maxX < speaker_Btn.frame.maxX               && btnThatMoves != speaker_Btn
                 ||
                 btnThatMoves.frame.maxX > copyText_forGoogleApp_Btn.frame.minX && btnThatMoves.frame.maxX < copyText_forGoogleApp_Btn.frame.maxX && btnThatMoves != copyText_forGoogleApp_Btn
                 ||
                 (btnThatMoves.frame.minX >    hideKeyboard_Btn.frame.minX
                  || btnThatMoves.frame.minX > seeTranslation_Btn.frame.minX
                  || btnThatMoves.frame.minX > speaker_Btn.frame.minX
                  || btnThatMoves.frame.minX > copyText_forGoogleApp_Btn.frame.minX))
         {
            Timer_Return_MiddleBtnsToCorrectPos_Left(btnThatMoves)
         }
         Restore_ShadowButtonsIfTouchedOutside()
         view.sendSubviewToBack(btnThatMoves)
         view.sendSubviewToBack(arrowUnderHideKeyboard_Btn)
         view.sendSubviewToBack(background_Middle_Btns)
      }
   }
   ///N-----------↓
   func       NextSentence_Method()
   {
      //В "theNumberOfConnectedSentences_Arr" вече има по 2 или 3 свързани иззречения(бройката им) и в "theSum_ofAllConnectedSentences" се добават още бройки на сумирани изречения
      //И когато се добават в "userDefault" вече имам сумата на всички достигнати изречения и мога да преброя до тях когато сменям "level"-a
      
      if(index_sentencePos < sentencesConnectedParts_fromTheLesson_Arr.count - 1)
      {
         index_sentencePos += 1
         
         // Добавяне на сумата от свързани изречения
         if(isSavedWords == false) {
            theSum_ofAllConnectedSentences += theSum_ofConnectedSentences_Arr[index_sentencePos]
            lastSentenceSumPos = theSum_ofConnectedSentences_Arr[index_sentencePos] // Взима броя на долепени изречения за да може да ги извадя когато се сменя левела от 3 на 1 и да започне от началопто на изречението, a не от края.
         }
         sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
         CreateSentence()
         isNoPrev_NextText = false
      }
      else {
         inputTextView_Second.text = "\n\n\n\n                🏁  END  🏁";
         isNoPrev_NextText = true
         index_sentencePos = sentencesConnectedParts_fromTheLesson_Arr.count
      }
      HideKeyboard()
      Restore_ShadowButtonsIfTouchedOutside()
   }
   ///P-----------↓
   func       PrevSentence_Method()
   {
      if (index_sentencePos > 0)
      {
         if(isSavedWords == false){
            theSum_ofAllConnectedSentences -= theSum_ofConnectedSentences_Arr[index_sentencePos]
            index_sentencePos -= 1
            lastSentenceSumPos = theSum_ofConnectedSentences_Arr[index_sentencePos] // Взима броя на долепени изречения за да може да ги извадя когато се сменя левела от 3 на 1 и да започне от началото на изречението, a не от края.
         }
         else { index_sentencePos -= 1 }
         
         sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
         CreateSentence()
         isNoPrev_NextText = false
      }
      else {
         if(isSavedWords == false && sentencesConnectedParts_fromTheLesson_Arr.count > 0) {
            theSum_ofAllConnectedSentences = theSum_ofConnectedSentences_Arr[index_sentencePos]
         }
         inputTextView_Second.text = "\n\n\n\n                🏁  START  🏁"
         isNoPrev_NextText = true
         index_sentencePos = -1
      }
      HideKeyboard()
      Restore_ShadowButtonsIfTouchedOutside()
   }
   func       ProgressBar_Progress()
   {
      let progrsBarIndex: Float = Float(index_sentencePos + 1) / Float(sentencesConnectedParts_fromTheLesson_Arr.count)
		var numberWordInSentence = sentenceOrWord_AfterShowingAllText.components(separatedBy: " ")
		var index = 0

		//Премахване на символи за да не се включват в бройката на думине от изречението
		while index < numberWordInSentence.count
		{
			if(numberWordInSentence[index] == ""
				|| numberWordInSentence[index] == "-"
				|| numberWordInSentence[index].contains("»")
				|| numberWordInSentence[index].contains("«")
				|| numberWordInSentence[index].contains("<")
				|| numberWordInSentence[index].contains(">")
				|| numberWordInSentence[index].contains("=")
				|| numberWordInSentence[index].contains("%"))
				{
				numberWordInSentence.remove(at: index)
			}
			else { index += 1 }
		}
      
      progressBar.setProgress(progrsBarIndex, animated: true)
      sentenceProgressIndex_Start.setTitle("\(index_sentencePos + 1)", for: .normal)
      sentenceProgressIndex_End.setTitle("\(sentencesConnectedParts_fromTheLesson_Arr.count - index_sentencePos - 1)", for: .normal)

		if(sentenceOrWord_AfterShowingAllText != "") {
         howMuchWords_inSentence.text = "\(numberWordInSentence.count)" }
      
      if(index_sentencePos < 6) { sentenceProgressIndex_Start.titleLabel!.font = UIFont.systemFont(ofSize: 12)}
      else if(index_sentencePos > 3) { sentenceProgressIndex_Start.titleLabel!.font = UIFont.boldSystemFont(ofSize: 12) }
      
      if(isSavedWords == true) {           // Показва бройката на изтритите научени думи за учене
         howMuchWords_inSentence.text = "\(sentencesConnectedParts_fromTheLesson_Arr.count - lessonSentencesAndWords_Arr.count)"
      }
   }
   func       PositionSet_HideSladingITV_Second()
   {
      inputTextView_Second.isHidden = false
      inputTextView_Second.text = sentenceOrWord_AfterShowingAllText
      inputTextView_Second.frame = CGRect.init(x: -(view.frame.width / 1.0133), y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
   }
   @objc func Paste_TouchedWordToTextView(_ touchedWord: String)
   {
      //Поставя докоснатата дума в inputTextView за превеждане без да изтрива останалите от изречението
      isSomeWord_Pressed = true
      
      Speak_Words(touchedWord)
      MakeTouchedWordReadyToTranslate(touchedWord)
   }
   func       Present_Method(_ itemToPresent: UIAlertController)
   {
      if(itemToPresent.message == "Size: \(index_textSize - 1)" || itemToPresent.message == "Size: \(index_textSize + 1)")
      {
         itemToPresent.message = "Size: \(index_textSize)";
      }
      
      self.present( itemToPresent, animated: true, completion: {
         [self] in                          //Тези се добавят за да се скрие менюто когато се натисне отстрани
         itemToPresent.view.superview?.isUserInteractionEnabled = true
         itemToPresent.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.DismissOnTapOutside_UIAlert)))
      })
   }
   @objc func Paste_TwoTimeTouchedWordToTextView(_ touchedWord: String)
   {
      //Поставяне на докосната (2 пъти) дума в inputTxtVIew за други преводи
      tapGesture.isEnabled = false
      ClearTextField_Btn(() as Any)
      inputTextView_One.text = touchedWord
   }
   ///R-----------↓
   func       ReturnThisLessonOrGoNext() // ↪️ ↩️ ☑️
   {
      if(voiceChoice_Int == -1) { return }
      
      var repNextOrDel = ""
      var lessonNameOrEnd = ""
      var nextLesson_name = ""
      
      if(isSavedWords == true)
      {
         repNextOrDel = "⁉️  Repeat this lesson or delete saved words file?"
         lessonNameOrEnd = "❌  Delete"
      }
      else {
         nextLesson_name = CheckForThisLesson()
         
         if(nextLesson_name == "End lesson")
         {
            repNextOrDel = "⁉️  Repeat this or go to the next lesson part?"
            lessonNameOrEnd = "✅ End"
         }
         else {
            let nextPart = nextLesson_name.components(separatedBy: " ")
            repNextOrDel = "⁉️  Repeat this or go to the next lesson part?"
            lessonNameOrEnd = "↪️ Part \(nextPart[nextPart.count - 1].replacingOccurrences(of: "\"", with: ""))"
         }
      }
      returnOrNextLesson = UIAlertController(title: repNextOrDel, message: nil, preferredStyle: .alert)
      if(sentencesConnectedParts_fromTheLesson_Arr.count > 0)
      {
         returnOrNextLesson.addAction(UIAlertAction(title: "↩️ Repeat", style: .default, handler: { [self] _ in Return_ToStartOfTheLesson() }))
      }
      returnOrNextLesson.addAction(UIAlertAction(title: lessonNameOrEnd, style: .default, handler: {
         [self] _ in
         if(isSavedWords == true) { Delete_SelectedLessonFile(lessonFileName) }
         else { Load_NextOrLastLesson(nextLesson_name) }
      }))
      //		returnOrNextLesson.addAction(UIAlertAction(title: "📙 Close", style: .cancel, handler: nil))
      Present_Method(returnOrNextLesson)
   }
   func       Return_ToStartOfTheLesson()
   {
      index_sentencePos = 0
      
      if(isSavedWords == false){
         theSum_ofAllConnectedSentences = theSum_ofConnectedSentences_Arr[0]
      }
      sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[0]
      saveSettings_Dictionary.set("\(0) \(0) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
      CreateSentence()
      inputTextView_Second.isHidden = false
      
      PositionSet_HideSladingITV_Second()
      Set_SentenceShowIndexColor(lessonFileName)
      Set_InputTextFrame_WhenLoadLesson()
      Timer_HideAllLessonTextAndField()
      
      if(isSpeak_savedWords == true && isSavedWords == true) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in Speaker() }
      }
   }
   @objc func Remove_AlphabetBtnsFromView() //🕛 timer Alphabet remove
   {
      if(alphabetLetters_StringArr.count < 1) { return }
      
      if(alphabetShowHide_isShow == false)
      {
         if(alphabetBtns_Arr.count < 1) //Когато азбуката се скрие
         {
            isPlayAplhabet_Pressed = false
            guessTheLetter_Btn.isHidden = true
            alphabetLetters_StringArr.removeAll()
            timer_ShowHideAlphabetLetters.invalidate()
            view.willRemoveSubview(guessTheLetter_Btn)
            extracted_textView.textColor = UIColor.label
            inputTextView_One.text = sentenceOrWord_AfterShowingAllText
            return
         }
         alphabetBtns_Arr.remove(at: alphabetBtns_Arr.count - 1).removeFromSuperview() // Изтрива буквите една по една
         
         if(timer_ShowHideAlphabetLetters.isValid == false) { // Старт на часовника за пказване на буквите
            if(isSavedWords == true) { guessTheLetter_Btn.isHidden = true }
            timer_ShowHideAlphabetLetters = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(Remove_AlphabetBtnsFromView), userInfo: nil, repeats: true)
         }
      }
      else
      {
         //Когато сменя езика и азбуката е показана
         for ABC_btn in alphabetBtns_Arr { ABC_btn.removeFromSuperview() }
         
         alphabetBtns_Arr.removeAll()
         alphabetLetters_StringArr.removeAll()
         timer_ShowHideAlphabetLetters.invalidate()
         index_ShowABCletters = 0
      }
   }
   func       ReachedNumbersOfGuessedLetters()
   {
      if(guessedLettersCount >= reachTheNumberOfGuessedLetters)
      {
         extracted_textView.text = "Correct: \(spokenL)\n"
         extracted_textView.text += "Guessed letters: \(guessedLettersCount) of \(reachTheNumberOfGuessedLetters)\n"
         reachTheNumberOfGuessedLetters += 10
      }
      let emoji10 = "🙂"
      let emoji20 = "🙃"
      let emoji30 = "😀"
      let emoji40 = "😜"
      let emoji50 = "🤓"
      let emoji60 = "😎"
      if(guessedLettersCount == 10){extracted_textView.text += "Yee! \(emoji10)"}
      else if(guessedLettersCount == 20){extracted_textView.text += "Yeeeee! \(emoji20)"}
      else if(guessedLettersCount == 30){extracted_textView.text += "SUPEEER! \(emoji30)"}
      else if(guessedLettersCount == 40){extracted_textView.text += "SUPER Yeeeee! \(emoji40)"}
      else if(guessedLettersCount == 50){
         if(voiceChoice_Int == 0){extracted_textView.text += "WOW! You are literally English! \(emoji50)"}
         else if(voiceChoice_Int == 1){extracted_textView.text += "WOW! Du är bokstavligen en Svensk! \(emoji50)"}
         else if(voiceChoice_Int == 2){extracted_textView.text += "WOW! Sie sind buchstäblich Deutscher! \(emoji50)"}
         else if(voiceChoice_Int == 3){extracted_textView.text += "WOW! Sei letteralmente italiano! \(emoji50)"}
      }
      else if(guessedLettersCount >= 60){extracted_textView.text += "\(emoji60)\(emoji60)\(emoji60)"}
   }
   func       ResetStatistic_ShowVocalLetters()
   {
      Choose_AlphabetLetters()
      Create_AlphabetButtons()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.Show_AlphabetLettersToView() }
      
      guessedLettersCount = 0
      reachTheNumberOfGuessedLetters = 10
      extracted_textView.text = ""
   }
   func       Restore_ShadowButtonsIfTouchedOutside()
   {
      for button in view.subviews
      {
         if(button ==    iKnowThisWord_btn
            || button == hideKeyboard_Btn
            || button == arrowUnderHideKeyboard_Btn
            || button == seeTranslation_Btn
            || button == speaker_Btn
            || button == copyText_forGoogleApp_Btn
            || button == clearTxt_Btn)
         {
            Shadow_Buttons(button)
         }
      }
   }
   func       Remove_Punctuation(_ someWord: String) -> String
   {
      var someWord = someWord
      someWord = someWord.replacingOccurrences(of: ".", with: "")
      someWord = someWord.replacingOccurrences(of: ",", with: "")
      someWord = someWord.replacingOccurrences(of: "!", with: "")
      someWord = someWord.replacingOccurrences(of: "?", with: "")
      someWord = someWord.replacingOccurrences(of: ":", with: "")
      someWord = someWord.replacingOccurrences(of: "\"", with: "")
      someWord = someWord.replacingOccurrences(of: "\\", with: "")
      someWord = someWord.replacingOccurrences(of: "(", with: "")
      someWord = someWord.replacingOccurrences(of: ")", with: "")
      someWord = someWord.lowercased()
      
      return someWord
   }
   func       Read_SelectedLessonFile(_ lessonFileName: String) -> String
   {
      var readedText = ""
      if  let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         let fileURL = dir.appendingPathComponent(lessonFileName)
         
         do { readedText = try String(contentsOf: fileURL, encoding: .utf8) }   //Reading
         catch{}
      }
      return readedText
   }
   @objc func Return_MiddleBtnsToDefaultPos_Left(_ timer_BtnThatMoves: Timer)
   {
      let dist = 0.2
      
      ///Auto moving and return button when is not pass the center of another button
      
      let btnThatMoves = timer_BtnThatMoves.userInfo as! UIButton
      btnThatMoves.frame = CGRect(x: btnThatMoves.frame.minX - distSlide, y: btnThatMoves.frame.minY, width: btnThatMoves.frame.width, height: btnThatMoves.frame.height)
      
      if(btnThatMoves == hideKeyboard_Btn) {
         arrowUnderHideKeyboard_Btn.frame = CGRect(x: btnThatMoves.frame.minX - distSlide, y: arrowUnderHideKeyboard_Btn.frame.minY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height) }
      
      if(btnThatMoves.frame.minX > hideKeyboard_Btn.frame.maxX - dist                  && btnThatMoves.frame.minX < hideKeyboard_Btn.frame.maxX + dist          && btnThatMoves != hideKeyboard_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > seeTranslation_Btn.frame.maxX - dist           && btnThatMoves.frame.minX < seeTranslation_Btn.frame.maxX + dist        && btnThatMoves != seeTranslation_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > speaker_Btn.frame.maxX - dist                  && btnThatMoves.frame.minX < speaker_Btn.frame.maxX + dist               && btnThatMoves != speaker_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > copyText_forGoogleApp_Btn.frame.maxX - dist    && btnThatMoves.frame.minX < copyText_forGoogleApp_Btn.frame.maxX + dist && btnThatMoves != copyText_forGoogleApp_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.maxX > hideKeyboard_Btn.frame.minX - dist             && btnThatMoves.frame.maxX < hideKeyboard_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > seeTranslation_Btn.frame.minX - dist        && btnThatMoves.frame.maxX < seeTranslation_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > speaker_Btn.frame.minX - dist               && btnThatMoves.frame.maxX < speaker_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > copyText_forGoogleApp_Btn.frame.minX - dist && btnThatMoves.frame.maxX < copyText_forGoogleApp_Btn.frame.minX + dist)
      {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      
      //After the moveds button is on its current position, another button maybe is outside the screen
      if(timer_MiddleIconReturnCorrectPos.isValid == false)	{
         Return_MiddleButtonsIfSomeoneIsOutsideTheScreen(btnThatMoves)
      }
   }
   @objc func Return_MiddleBtnsToDefaultPos_Right(_ timer_BtnThatMoves: Timer)
   {
      let dist = 0.2
      
      ///Auto moving and return button when is not pass the center of another button
      
      let btnThatMoves = timer_BtnThatMoves.userInfo as! UIButton
      btnThatMoves.frame = CGRect(x: btnThatMoves.frame.minX + distSlide, y: btnThatMoves.frame.minY, width: btnThatMoves.frame.width, height: btnThatMoves.frame.height)
      
      if(btnThatMoves == hideKeyboard_Btn) {
         arrowUnderHideKeyboard_Btn.frame = CGRect(x: btnThatMoves.frame.minX + distSlide, y: arrowUnderHideKeyboard_Btn.frame.minY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height)
      }
      
      if(btnThatMoves.frame.minX > hideKeyboard_Btn.frame.maxX -        dist        && btnThatMoves.frame.minX < hideKeyboard_Btn.frame.maxX +  dist         && btnThatMoves != hideKeyboard_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > seeTranslation_Btn.frame.maxX - dist        && btnThatMoves.frame.minX < seeTranslation_Btn.frame.maxX + dist        && btnThatMoves != seeTranslation_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > speaker_Btn.frame.maxX -        dist        && btnThatMoves.frame.minX < speaker_Btn.frame.maxX +        dist        && btnThatMoves != speaker_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.minX > copyText_forGoogleApp_Btn.frame.maxX - dist && btnThatMoves.frame.minX < copyText_forGoogleApp_Btn.frame.maxX + dist && btnThatMoves != copyText_forGoogleApp_Btn) {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      else if(btnThatMoves.frame.maxX > hideKeyboard_Btn.frame.minX - dist             && btnThatMoves.frame.maxX < hideKeyboard_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > seeTranslation_Btn.frame.minX - dist        && btnThatMoves.frame.maxX < seeTranslation_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > speaker_Btn.frame.minX - dist               && btnThatMoves.frame.maxX < speaker_Btn.frame.minX + dist
              || btnThatMoves.frame.maxX > copyText_forGoogleApp_Btn.frame.minX - dist && btnThatMoves.frame.maxX < copyText_forGoogleApp_Btn.frame.minX + dist)
      {
         timer_MiddleIconReturnCorrectPos.invalidate()
      }
      
      //After the moveds button is on its current position, another button maybe is outside the screen
      if(timer_MiddleIconReturnCorrectPos.isValid == false)	{
         Return_MiddleButtonsIfSomeoneIsOutsideTheScreen(btnThatMoves)
      }
   }
   func       Return_MiddleButtonsIfSomeoneIsOutsideTheScreen(_ btnThatMoves: UIButton) // 375 = x * 20
   {
      //If the swap Method doesn't work properly, here is method that returns the button when it is outside the screen
      let dist = view.frame.width / 18.75
      let btnWidth = speaker_Btn.frame.width
      
      if(hideKeyboard_Btn.frame.minX <          dist) {
         hideKeyboard_Btn.frame =           CGRect(x: dist, y: hideKeyboard_Btn.frame.minY,           width: hideKeyboard_Btn.frame.width,           height: hideKeyboard_Btn.frame.height)
         arrowUnderHideKeyboard_Btn.frame = CGRect(x: dist, y: arrowUnderHideKeyboard_Btn.frame.minY, width: arrowUnderHideKeyboard_Btn.frame.width, height: arrowUnderHideKeyboard_Btn.frame.height)
      }
      if(seeTranslation_Btn.frame.minX <        dist) {
         seeTranslation_Btn.frame =        CGRect(x: dist, y: seeTranslation_Btn.frame.minY,          width: seeTranslation_Btn.frame.width,         height: seeTranslation_Btn.frame.height)
      }
      if(speaker_Btn.frame.minX <               dist) {
         speaker_Btn.frame =               CGRect(x: dist, y: speaker_Btn.frame.minY,                 width: speaker_Btn.frame.width,                height: speaker_Btn.frame.height)
      }
      if(copyText_forGoogleApp_Btn.frame.minX < dist) {
         copyText_forGoogleApp_Btn.frame = CGRect(x: dist, y: copyText_forGoogleApp_Btn.frame.minY,   width: copyText_forGoogleApp_Btn.frame.width,  height: copyText_forGoogleApp_Btn.frame.height)
      }
      //--------------------------------------------------------------------------
      if(hideKeyboard_Btn.frame.maxX > view.frame.width) {
         hideKeyboard_Btn.frame =          CGRect(x: view.frame.width - btnWidth - dist, y: hideKeyboard_Btn.frame.minY,          width: hideKeyboard_Btn.frame.width,          height: hideKeyboard_Btn.frame.height)
      }
      if(seeTranslation_Btn.frame.maxX > view.frame.width) {
         seeTranslation_Btn.frame =        CGRect(x: view.frame.width - btnWidth - dist, y: seeTranslation_Btn.frame.minY,        width: seeTranslation_Btn.frame.width,        height: seeTranslation_Btn.frame.height)
      }
      if(speaker_Btn.frame.maxX > view.frame.width) {
         speaker_Btn.frame =               CGRect(x: view.frame.width - btnWidth - dist, y: speaker_Btn.frame.minY,               width: speaker_Btn.frame.width,               height: speaker_Btn.frame.height)
      }
      if(copyText_forGoogleApp_Btn.frame.maxX > view.frame.width) {
         copyText_forGoogleApp_Btn.frame = CGRect(x: view.frame.width - btnWidth - dist, y: copyText_forGoogleApp_Btn.frame.minY, width: copyText_forGoogleApp_Btn.frame.width, height: copyText_forGoogleApp_Btn.frame.height)
      }
   }
   func       ReplacingOccurrences_LessonFileName(_ lessonFileName: String)  -> String
   {
      //Поставяне на цифров еквивалент на символ-разделител след всяка дума
      var fileLessonName = lessonFileName.replacingOccurrences(of: ".txt", with: "")
      fileLessonName = fileLessonName.replacingOccurrences(of: selectedLanguage_Str + lesson_forLearning_Str, with: "")
      fileLessonName = fileLessonName.replacingOccurrences(of: "[", with: "")
      fileLessonName = fileLessonName.replacingOccurrences(of: "]", with: "")
      fileLessonName = fileLessonName.replacingOccurrences(of: "_toLearn", with: "")
      
      return fileLessonName
   }
   func       ReplacingOccurrences_LessonNameToLabel(_ someLessonNameInput: String) -> String
   {
      var someLessonName = someLessonNameInput
      someLessonName = someLessonName.replacingOccurrences(of: ".txt", with: "")
      someLessonName = "\"" + someLessonName.replacingOccurrences(of: selectedLanguage_Str + lesson_forLearning_Str, with: "") + "\""
      
      return someLessonName
   }
   ///S-----------↓
   func       SpeakingSpeed() //1️⃣-8️⃣ ⏸ 🔊
   {
      //1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣ ⏸ 🔊 🔈
      // var imageNumber = ""
      let speedSpeakNumbers_Arr = [String] (arrayLiteral: "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣")
      
      speedSpeak_index += 0.1
      if (speedSpeak_index > 0.7) { speedSpeak_index = 0.1 }
      
      imageNumber = speedSpeakNumbers_Arr[Int((speedSpeak_index - 0.1) * 10)]
   }
   @objc func Show_StartText() // Hello - Star text
   {
      var startTextLanguage = ""
      let startTextBG = "   Здравейте! Да започваме! \nПоставете тук своя текст, на езика, който искате да научите. Запази го. И след това го заредете."
      let startTextEN = "   Hello! Let's start! \nPlace your text here, in the language you want to learn. Keep it. And then load it."
      let startTextSV = "   Hallå! Låt oss börja! \nPlacera din text här, på det språk du vill lära dig. Behåll det. Och sedan ladda den."
      let startTextDE = "   Hallo! Lasst uns beginnen! \nPlatzieren Sie hier ihren text in der sprache, die Sie lernen möchten. Behalte es. Und dann aufladen."
      let startTextIT = "   Ciao! Iniziamo! \nMetti qui il tuo testo, nella lingua che vuoi imparare. Tienilo. E poi caricarlo."
      
      if(voiceChoice_Int == -1) { startTextLanguage = startTextBG }
      else if(voiceChoice_Int == 0)  { startTextLanguage = startTextEN }
      else if(voiceChoice_Int == 1)  { startTextLanguage = startTextSV }
      else if(voiceChoice_Int == 2)  { startTextLanguage = startTextDE }
      else if(voiceChoice_Int == 3)  { startTextLanguage = startTextIT }
      
      inputTextView_One.text += "\(startTextLanguage[startTextLanguage.index(startTextLanguage.startIndex, offsetBy: index_ShowStartTxt)])"
      index_ShowStartTxt += 1
      if(index_ShowStartTxt > startTextLanguage.count - 1)
      {
         timer_ShowStartText.invalidate()
         index_ShowStartTxt = 0
      }
   }
   func       SaveLesson_Method() // 💾 📔
   {
      if(voiceChoice_Int == -1) { Show_IsNoLanguageSelected_Alert();  return }
      
      if(isSavedWords == true) {
         extracted_textView.isHidden = false
         
         if(isAllLessonText == false) { extracted_textView.text =   "⚠️ Can't save a lesson right now!" }
         else if(isAllLessonText == true) { inputTextView_One.text += "\n⚠️ Can't save a lesson right now!" }
         return
      }
      
      if(inputTextView_One.text.trimmingCharacters(in: .whitespacesAndNewlines) != "")
      {
         let alertMessgSaveProgs = UIAlertController(title: "Save lesson?", message: nil, preferredStyle: .alert)
         alertMessgSaveProgs.addTextField { (textField) in textField.placeholder = "Name of the lesson" }
         
         if(isAllLessonText == true) {    // Показва името на настоящия фаил, ако искам да го презапиша
            lessonFileName = lessonFileName.replacingOccurrences(of: ".txt", with: "")
            alertMessgSaveProgs.textFields?.first?.text = lessonFileName.replacingOccurrences(of: selectedLanguage_Str + lesson_forLearning_Str, with: "")}
         
         alertMessgSaveProgs.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            [self]ACTION in
               ///Create and append lesson file
            lessonFileName = alertMessgSaveProgs.textFields![0].text!
            
            if(lessonFileName == ""){
               lessonFileName = selectedLanguage_Str + lesson_forLearning_Str + "Some lesson" }
            else {
               lessonFileName = selectedLanguage_Str + lesson_forLearning_Str + lessonFileName }
            
            SplitLessonTextIntoSentences(inputTextView_One.text)
            if(isSavedWords == false) {
               SeparateTheLesson_IntoFiftySentences() //Добавяне на cutSymbol и номер на разделените файлове
            }
            lessonName_Label.text = ReplacingOccurrences_LessonNameToLabel(lessonFileName)
            isMenuShow = false
            isAllLessonText = false
            learnedLessonMarker = ""
            isITV_One_becomeFirstRes = false
            edit_lessonsText_Btn.isEnabled = true
            
            if(sentenceLength_Level == 1)      { Connect_OnePartOfSentence() }
            else if(sentenceLength_Level == 2) { Connect_TwoPartsOfSentence() }
            else if(sentenceLength_Level == 3) { Connect_WholeSentenceFromLesson() }
            //if(sentenceLength_Level == 4){ Get_TwoWholeSentencesFromLesson() }
            
            index_sentencePos = 0
            theSum_ofAllConnectedSentences = theSum_ofConnectedSentences_Arr[0]
            saveSettings_Dictionary.set("\(index_sentencePos) \(theSum_ofAllConnectedSentences) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
            saveSettings_Dictionary.set("\(lessonFileName)", forKey: selectedLanguage_Str + lastOpenedFile_str)
            
            sentenceOrWord_AfterShowingAllText = sentencesConnectedParts_fromTheLesson_Arr[index_sentencePos]
            
            Set_SentenceShowIndexColor(lessonFileName)
            PositionSet_HideSladingITV_Second()
            Set_InputTextFrame_WhenLoadLesson()
            Timer_HideAllLessonTextAndField()
         }))
         alertMessgSaveProgs.addAction(UIAlertAction(title: "No", style: .default, handler: { [self] ACTION in  lessonFileName = lessonFileName + ".txt";  isMenuShow = false }))
         present(alertMessgSaveProgs, animated: true, completion: nil)
      }
      else { inputTextView_One.text = "No text to save!\n" }
   }
   @objc func Show_AlphabetLettersToView() //🕛 timer Alphabet
   {
      if(index_ShowABCletters > alphabetBtns_Arr.count - 1){
         index_ShowABCletters = 0
         timer_ShowHideAlphabetLetters.invalidate()
         return
      }
      view.addSubview(alphabetBtns_Arr[index_ShowABCletters])
      index_ShowABCletters += 1
      
      if(timer_ShowHideAlphabetLetters.isValid == false){
         timer_ShowHideAlphabetLetters = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(Show_AlphabetLettersToView), userInfo: nil, repeats: true)
      }
   }
   func       SeeTranslation_AnimatedClock() //🕛🕐🕑 Start
   {
      seeTranslation_Btn.setImage(UIImage(named: "animate_clock-\(index_animatedClock)"), for: .normal)
      index_animatedClock += 1
      if (timer_seeTranslationAnimateClock.isValid == false)
      {
         timer_seeTranslationAnimateClock = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(SeeTranslationAnimateClock_Parameters), userInfo: nil, repeats: true)
      }
   }
   func       Show_Hide_AlphabetLetters() // Alphabet 🔠
   {
      //		if(isAllLessonText == true) { return }
      if(alphabetShowHide_isShow == false)
      {
         InputTextView_DefaulColorAndState()
         alphabetShowHide_isShow = true
         Choose_AlphabetLetters()
         Create_AlphabetButtons()
         Show_AlphabetLettersToView()
         Shadow_Buttons(guessTheLetter_Btn!)
         
         inputTextView_One.attributedText = nil
         extracted_textView.text = ""
         extracted_textView.isHidden = false
         guessTheLetter_Btn.isHidden = false
         next_prev_words_PanGesture.isEnabled = false
         
         if(isSavedWords == true) { iKnowThisWord_btn.isHidden = true }
      }
      else {
         alphabetShowHide_isShow = false
         Remove_AlphabetBtnsFromView()
         extracted_textView.becomeFirstResponder()
         extracted_textView.isHidden = true
         extracted_textView.text = nil
         next_prev_words_PanGesture.isEnabled = true
         
         if(isSavedWords == true) { iKnowThisWord_btn.isHidden = false }
      }
      HideKeyboard()
      speakerSynthesizer.stopSpeaking(at: .immediate)
   }
   @objc func Shadow_Buttons(_ forShadow: Any)
   {
      (forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor
      (forShadow as AnyObject).layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
      (forShadow as AnyObject).layer.shadowOpacity = 1.0
      (forShadow as AnyObject).layer.shadowRadius = 4.5
   }
   func       SentenceIndexBorder (_ btn: Any)
   {
      (btn as AnyObject).layer.cornerRadius = 8
   }
   func       Speak_Words(_ charOrWord: String) // 🔊 Alphabet
   {
      var letter: String = ""
      var speakText = AVSpeechUtterance()
      let speakVoiceArr = [String](arrayLiteral:"en-GB", "sv-SE", "de-DE","it-IT")
      
      //Подготвяне на гласа
      if(speakerSynthesizer.isPaused == true) { return }
      
      letter = charOrWord
      speakText = AVSpeechUtterance(string: letter)
      speakText.rate = Float(speedSpeak_index)
      speakText.voice = AVSpeechSynthesisVoice(language: "\(speakVoiceArr[voiceChoice_Int])")
      speaker_Btn.setTitle("🔊", for: .normal)
      
      //Изговаряне на текста
      speakerSynthesizer.speak(speakText)
   }
   func       Show_IsNoLanguageSelected_Alert()
   {
      extracted_textView.isHidden = false
      extracted_textView.text = "🙂😉 Oops\nNo language selected."
   }
   @objc func Show_AllLessonText_FieldAnimate()
   {
      inputTextView_One.frame =              CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
      background_ITV_One_showAllText.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
      posX_object += 0.6
      
      if(posX_object > view.frame.width / 20.0)  //Часовник за ефекта на плъзгане наляво и надясно на полето "inputTextView_One")
      {
         timer_ShowStartText.invalidate()
         timer_showHide_AllLessonsText.invalidate()
      }
   }
   func       Shadow_Sentences(_ forShadow: Any)
   {
      (forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.80).cgColor
      (forShadow as AnyObject).layer.shadowOffset = CGSize(width: 2, height: 2)
      (forShadow as AnyObject).layer.shadowOpacity = 0.75
      (forShadow as AnyObject).layer.shadowRadius = 4
   }
   func       Save_EndSentence_GreenProgressBar()
   {
      if(index_sentencePos >= sentencesConnectedParts_fromTheLesson_Arr.count - 1 && index_sentencePos > -1)
      {
         sentenceProgressIndex_Start.backgroundColor = UIColor.systemGreen
         sentenceProgressIndex_End.backgroundColor = UIColor.systemGreen
         learnedLessonMarker = learnedLessonSymbol     // saveSettings_Dictionary.set(......) е тук защото learnedLessonMarker се задава в този метод
         
         saveSettings_Dictionary.set("\(index_sentencePos) \(theSum_ofAllConnectedSentences) \(lessonFileName) \(learnedLessonMarker)", forKey: lessonFileName)
      }
   }
   func       Set_InputTextFrame_WhenLoadLesson()
   {
      if(isAllLessonText == true) {
         posX_object =   view.frame.width / 20.0
         posY_object =   view.frame.height / 6.3
         width_object =  view.frame.width  / 1.125
         height_object = view.frame.height / 2.15
      }
      else {
         if(inputTextView_One.frame.minX > 5) { posX_object = view.frame.width / 20.242 }
         else { posX_object =   5 }
         posY_object =   inputTextView_One.frame.minY
         width_object =  inputTextView_One.frame.width
         height_object = inputTextView_One.frame.height
      }
   }
   func       SeparateTheLesson_IntoFiftySentences() /// 🧬 🔪 ✂️ ✄ ✂︎
   {
      ///Разделяне текста на изречения и записване в паметта на телефона
      var devideIndex = 50
      let cutSymbol = "🧬"    //🧬 🔪 ✂️ ✄ ✂︎
      
      if(lessonSentencesAndWords_Arr.count > devideIndex  && !lessonFileName.contains(cutSymbol))//Проверява дали са над 50
      {
         var index = 0
         var fileNumber = 0
         var onlyFiftySentences_Str = ""
         let devideIndex_Temp = devideIndex
         let lessonFileName_Temp = lessonFileName
         var onlyFiftySentences_Array = [String]()
         
         //Ако са над 50 с "while" цикъл събира 50 изречения в една променливата "onlyFiftySentences_Str"
         while (index < lessonSentencesAndWords_Arr.count)
         {
            onlyFiftySentences_Str += lessonSentencesAndWords_Arr[index] + " \n "
            
            if(index >= devideIndex - 1 && lessonSentencesAndWords_Arr[index].last == ".")
            {
               fileNumber += 1
               devideIndex = index + devideIndex_Temp
               lessonFileName = lessonFileName_Temp + " \(cutSymbol)\(fileNumber).txt"
               WriteText_IntoFIle(onlyFiftySentences_Str) //Записва текста от тази променлива във файл и й добавя число в края
               onlyFiftySentences_Str = ""
            }
            else if(index == lessonSentencesAndWords_Arr.count - 1) //За последното изречение от целия текст
            {
               fileNumber += 1
               lessonFileName = lessonFileName_Temp + " \(cutSymbol)\(fileNumber).txt"
               WriteText_IntoFIle(onlyFiftySentences_Str)
            }
            index += 1
         }
         
         for index in 0...lessonSentencesAndWords_Arr.count - 1   //Прехвърляне на 50 и повече изречения за учене на първия урок
         {
            if(index < devideIndex_Temp) {
					onlyFiftySentences_Array.append(lessonSentencesAndWords_Arr[index]) }
         }
         lessonSentencesAndWords_Arr.removeAll()
         lessonSentencesAndWords_Arr = onlyFiftySentences_Array
         onlyFiftySentences_Array.removeAll()
         lessonFileName = lessonFileName_Temp + " \(cutSymbol)\(1).txt" //За да маркира първия файл от разделения урок като отворен
      }
      else {  //Ако са под 50 изрчения, директно записва файла.
         lessonFileName = lessonFileName + ".txt"
         WriteText_IntoFIle(self.inputTextView_One.text) }
   }
   @objc func SeeTranslationAnimateClock_Parameters() //🕛🕐🕑
   {
      //"🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", "🕕", "🕡", "🕖", "🕢", "🕗", "🕣", "🕘", "🕤", "🕙", "🕥", "🕚", "🕦", "🕛")
      //let animatedClock_Arr = [UIImage](arrayLiteral: UIImage(named: "animate_clock-1")!, UIImage(named: "animate_clock-2")!, 3, 4, 5, 6,......... )
      
      if(index_animatedClock > 30) {
         index_animatedClock = 1
      }
      seeTranslation_Btn.setImage(UIImage(named: "animate_clock-\(index_animatedClock)"), for: .normal)
      index_animatedClock += 1
   }
   func       Shadow_EndProgressImage(_ forShadow: Any)
   {
      (forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor
      (forShadow as AnyObject).layer.shadowOffset = CGSize(width: 5.5, height: 5.5)
      (forShadow as AnyObject).layer.shadowOpacity = 5.0
      (forShadow as AnyObject).layer.shadowRadius = 5.5
   }
   func       Shadow_LearnLngBtn_Text(_ forShadow: Any)
   {
      (forShadow as AnyObject).layer.shadowOffset = CGSize(width: 2, height: 2)
      (forShadow as AnyObject).layer.shadowOpacity = 1.0
      (forShadow as AnyObject).layer.shadowRadius = 3.0
   }
   @objc func Speak_AlphabetLetter(_ charOrWord: UIButton) // 🔊 Alphabet
   {
      var letter: String = ""
      var speakText = AVSpeechUtterance()
      let speakVoiceArr = [String](arrayLiteral:"en-GB", "sv-SE", "de-DE","it-IT")
      
      //Подготвяне на гласа
      if(speakerSynthesizer.isPaused == true){ return }
      
      letter = (charOrWord.titleLabel?.text!)!
      speakText = AVSpeechUtterance(string: letter)
      speakText.rate = Float(speedSpeak_index)
      speakText.voice = AVSpeechSynthesisVoice(language: "\(speakVoiceArr[voiceChoice_Int])")
      speaker_Btn.setTitle("🔊", for: .normal)
      
      //Изговаряне на текста
      speakerSynthesizer.speak(speakText)
   }
   @objc func Shadow_ButtonsPressed_Method(_ forShadow: Any)
   {
      (forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor
      (forShadow as AnyObject).layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
      (forShadow as AnyObject).layer.shadowOpacity = 1.0
      (forShadow as AnyObject).layer.shadowRadius = 1.0
   }
   @objc func Save_NewWordsForLearning(_ touchedWord: String) //New Word
   {
      //Когато се натисне върху дума от изречение, но не и когато се учат запаметените думи, тя се запаметява за учене
      var newWord_ForLearning = touchedWord
      newWord_ForLearning = newWord_ForLearning.lowercased()
      
      let wordsFile_ForLearning_Str = selectedLanguage_Str + words_forLearning_Str + ".txt"
      var newWordsForLearning_Arr = [String]()
      var newWords_toLearn = ""
      
      if  let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         let fileURL = dir.appendingPathComponent(wordsFile_ForLearning_Str)
         
         do {
            newWords_toLearn = try String(contentsOf: fileURL, encoding: .utf8) }  //--- Reading content of the file ---
         catch{}
      }
      
      newWordsForLearning_Arr = newWords_toLearn.components(separatedBy: ["\n"])
      
      for newSavedWord in newWordsForLearning_Arr
      {
         if (newSavedWord == newWord_ForLearning) { return }
      }
      newWords_toLearn += newWord_ForLearning + "\n"
      count_nweWorldsToLearn = count_nweWorldsToLearn + 1
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      {
         //Create and append lesson file
         let saved_NewWord_FileURL = dir.appendingPathComponent(wordsFile_ForLearning_Str)
         
         //Writing into file and into saveSettings_Dictionary-Dictionary
         do {
            try newWords_toLearn.write(to: saved_NewWord_FileURL, atomically: false, encoding: .utf8) }
         catch {}
      }
   }
   func       Set_SentenceShowIndexColor(_ lessonFileName:String)
   {
      let getSettingsStr = saveSettings_Dictionary.string(forKey: lessonFileName)
      
      if(getSettingsStr == nil) //Решение на проблема с Шведските букви. Незнам защо работи така
      {
         sentenceProgressIndex_Start.backgroundColor = UIColor.systemGray3
         sentenceProgressIndex_End.backgroundColor = UIColor.systemGray3
      }
      else {
         let getSettingsArr = getSettingsStr!.components(separatedBy: " ")
         
         if(getSettingsArr[getSettingsArr.count - 1].contains(learnedLessonSymbol))
         {
            sentenceProgressIndex_Start.backgroundColor = UIColor.systemGreen
            sentenceProgressIndex_End.backgroundColor = UIColor.systemGreen
         }
         else {
            sentenceProgressIndex_Start.backgroundColor = UIColor.systemGray3
            sentenceProgressIndex_End.backgroundColor = UIColor.systemGray3 }
      }
   }
   func       Set_InputTextFrame_WhenLoadLesson_Position(_ posX: Double)
   {
      posX_object += posX
      
      inputTextView_One.frame =              CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
      background_ITV_One_showAllText.frame = CGRect.init(x: posX_object, y: posY_object, width: width_object, height: height_object)
      
      if(edit_lessonsText_Btn.isEnabled == true && isAllLessonText == false)
      {
         inputTextView_Second.frame = CGRect.init(x: inputTextView_Second.frame.minX + posX, y: inputTextView_Second.frame.minY, width: inputTextView_Second.frame.width, height: inputTextView_Second.frame.height)
         extracted_textView.frame =   CGRect.init(x: extracted_textView.frame.minX + posX,   y: extracted_textView.frame.minY, width:   extracted_textView.frame.width,   height: extracted_textView.frame.height)
      }
   }
   func       SplitLessonTextIntoSentences(_ savingOrLoading_Text: String) // Split Sentense
   {
      //Добавяне в масива и разделяне на изречения
      var addSplitter = savingOrLoading_Text
      addSplitter = addSplitter.replacingOccurrences(of: "\n",    with: "♪")
      addSplitter = addSplitter.replacingOccurrences(of: "\r",    with: "")
      addSplitter = addSplitter.replacingOccurrences(of: "  ",    with: " ")
      addSplitter = addSplitter.replacingOccurrences(of: ".\"",   with: ".\" ♪") // new 17.10.2022
      addSplitter = addSplitter.replacingOccurrences(of: ".",     with: ". ♪")
      addSplitter = addSplitter.replacingOccurrences(of: ",\"",   with: ",\" ♫")
      addSplitter = addSplitter.replacingOccurrences(of: ",",     with: ", ♫")
      addSplitter = addSplitter.replacingOccurrences(of: ";",     with: "; ♥")
      addSplitter = addSplitter.replacingOccurrences(of: ":",     with: ": ♣")
      addSplitter = addSplitter.replacingOccurrences(of: "!\"",   with: "!\" ♦") // new 17.10.2022
      addSplitter = addSplitter.replacingOccurrences(of: "!",     with: "! ♦")
      addSplitter = addSplitter.replacingOccurrences(of: "?\"",   with: "?\" ♠") // new 17.10.2022
      addSplitter = addSplitter.replacingOccurrences(of: "?",     with: "? ♠")
      addSplitter = addSplitter.replacingOccurrences(of: "…",     with: "… ∞")
      addSplitter = addSplitter.replacingOccurrences(of: " och ", with: " * och ")
      addSplitter = addSplitter.replacingOccurrences(of: " and ", with: " ◦ and ")
      addSplitter = addSplitter.replacingOccurrences(of: "”",     with: "\"")  //Смяна на тези кавички за да има пауза при изговаряне, където има такива кавички
      
      lessonSentencesAndWords_Arr = addSplitter.components(separatedBy: ["♪", "♫", "♥", "♣", "♦", "♠", "*", "∞", "◦"])
      
      var index = 0
      //Премахване на новите редове и празни позиции.
      while(index < lessonSentencesAndWords_Arr.count && lessonSentencesAndWords_Arr.count > 0)
      {
         while(lessonSentencesAndWords_Arr[index].first == " " || lessonSentencesAndWords_Arr[index].first == "\n")
         {
            lessonSentencesAndWords_Arr[index].removeFirst()
         }
         while(lessonSentencesAndWords_Arr[index].last == " ")
         {
            lessonSentencesAndWords_Arr[index].removeLast()
         }
         if(lessonSentencesAndWords_Arr[index] != "" )
         {
            lessonSentencesAndWords_Arr[index] = lessonSentencesAndWords_Arr[index].replacingOccurrences(of: "\n", with: "")
            lessonSentencesAndWords_Arr[index] = lessonSentencesAndWords_Arr[index].replacingOccurrences(of: "\r", with: "")
         }
         if(lessonSentencesAndWords_Arr[index] == "" || lessonSentencesAndWords_Arr[index] == " ")
         {
            lessonSentencesAndWords_Arr.remove(at: index);
            if(index > 0) { index -= 1 }
         }
         if(lessonSentencesAndWords_Arr[index] == "\"") //Премахване на кавички които са след точка, защото сa като отделно изречение.
         {
            lessonSentencesAndWords_Arr[index - 1] = lessonSentencesAndWords_Arr[index - 1] + lessonSentencesAndWords_Arr[index]
            lessonSentencesAndWords_Arr.remove(at: index)
            index -= 1
         }
         index += 1
      }
      sentenceProgressIndex_Start.backgroundColor = UIColor.systemGray3
      sentenceProgressIndex_End.backgroundColor =   UIColor.systemGray3
   }
   func       Shadow_BorderAndAllLessonText(_ textView_Border_Shadow: Any)
   {
      (textView_Border_Shadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
      (textView_Border_Shadow as AnyObject).layer.shadowOffset = CGSize(width: 16, height: 16)
      (textView_Border_Shadow as AnyObject).layer.shadowOpacity = 1
      (textView_Border_Shadow as AnyObject).layer.shadowRadius = 12
   }
   func       speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance)
   {
      if(isSavedWords == false
         && extracted_textView.text.isEmpty
         && alphabetShowHide_isShow == false
         && extracted_textView.isHidden == false
         && timer_seeTranslationAnimateClock.isValid == false)
      {
         extracted_textView.attributedText =  CreateAttributedString(sentenceOrWord_translatedText)
      }
      speaker_Btn.setTitle("🔈", for: .normal)// 🔊 - speaker with high volume; 🔈 - speaker
      isRepeatedWord = ""
   }
   ///T-----------↓
   func       TextHeight_Max()
   {
      if (index_textSize < 30) {index_textSize += 1}
      TextSize_Method()
   }
   func       TextHeight_Min()
   {
      if (index_textSize > 10) {index_textSize -= 1}
      TextSize_Method()
   }
   func       TextSize_Method()
   {
      inputTextView_One.font    = UIFont(name: fontName, size: CGFloat(index_textSize))
      inputTextView_Second.font = UIFont(name: fontName, size: CGFloat(index_textSize))
      extracted_textView.font   = UIFont(name: fontName, size: CGFloat(index_textSize))
   }
   func       Timer_ShowStartText()
   {
      timer_ShowStartText = Timer.scheduledTimer(timeInterval: 0.012, target: self, selector: #selector(Show_StartText), userInfo: nil, repeats: true)
   }
   func       Timer_HideAllLessonTextAndField()
   {
      timer_showHide_AllLessonsText = Timer.scheduledTimer(timeInterval: 0.0005, target: self, selector: #selector(Hide_AllLessonTextAndField), userInfo: nil, repeats: true)
   }
   func       TouchedWordAtPosition(_ point: CGPoint) -> String?
   {
      if let textPosition = inputTextView_One.closestPosition(to: point)
      {
         let dir = UITextDirection(rawValue: 0)
         let range = inputTextView_One.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: dir)
         if (range != nil)
         {
            let wordTouched = inputTextView_One.text(in: range!)
            return wordTouched
         }
      }
      return ""
   }
   func       textViewDidBeginEditing(_ textView: UITextView) // Кликнато на празното за промяна на дума или изречение
   {
      if(isAllLessonText == true) { return }
      
      if(isITV_One_becomeFirstRes == false)
      {
         isITV_One_becomeFirstRes = true
         inputTextView_One.text = sentenceOrWord_AfterShowingAllText
      }
   }
   func       Timer_Return_MiddleBtnsToCorrectPos_Left(_ btnThatMoves: UIButton)
   {
      timer_MiddleIconReturnCorrectPos = Timer.scheduledTimer(timeInterval: 0.0006, target: self, selector: #selector(Return_MiddleBtnsToDefaultPos_Left), userInfo: btnThatMoves, repeats: true)
   }
   func       Timer_Return_MiddleBtnsToCorrectPos_Right(_ btnThatMoves: UIButton)
   {
      timer_MiddleIconReturnCorrectPos = Timer.scheduledTimer(timeInterval: 0.0006, target: self, selector: #selector(Return_MiddleBtnsToDefaultPos_Right), userInfo: btnThatMoves, repeats: true)
   }
   ///W-----------↓
   func       WriteText_IntoFIle(_ text_forWrite: String) // ✍🏻 - Write splited text
   {
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first //Devine the directory to write into
      {
         let lessonFileName_URL = dir.appendingPathComponent(lessonFileName) //Create lesson file
         do
         {
            try text_forWrite.write(to: lessonFileName_URL, atomically: false, encoding: .utf8)  //Writing into a file
         }
         catch {}
      }
   }
}
