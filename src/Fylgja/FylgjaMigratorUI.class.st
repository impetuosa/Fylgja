"
This UI version manages three different models. 
"
Class {
	#name : #FylgjaMigratorUI,
	#superclass : #FylgjaMigratorSingleDestinationUI,
	#instVars : [
		'secondDestinationBundle'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaMigratorUI class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #toolbar;
				   add: #version width: 100;
				   yourself)
		  height: self toolbarHeight + 10;
		  add: (SpPanedLayout newTopToBottom
				   positionOfSlider: 80 percent;
				   add: (SpPanedLayout newLeftToRight
						    positionOfSlider: 50 percent;
						    add: #originBundle;
						    add: (SpPanedLayout newTopToBottom
								     positionOfSlider: 50 percent;
								     add: #firstDestinationBundle;
								     add: #secondDestinationBundle));
				   add: #bottomControlNotebook)
]

{ #category : #initialization }
FylgjaMigratorUI >> initializePresenters [

	super initializePresenters.
	secondDestinationBundle := self newMoxingBundle.
	secondDestinationBundle modelAccessor: [ :controller | 
		controller destinations second ]
]

{ #category : #initialization }
FylgjaMigratorUI >> ruleHasBeenAppliedSuccessfully [

	" Should be refreshing all "

	originBundle ruleHasBeenAppliedSuccessfully.
	firstDestinationBundle ruleHasBeenAppliedSuccessfully.
	secondDestinationBundle ruleHasBeenAppliedSuccessfully.

	self updateVersionLabel
]
