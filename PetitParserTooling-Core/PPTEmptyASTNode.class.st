"
I am an exception stored when in a rule nothing remains to be stored.
It can happens if a rule depends on ignored rules and tokens only.
The solution can be to ignore also this rule or to flatten this rule.
"
Class {
	#name : #PPTEmptyASTNode,
	#superclass : #Error,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core-Exceptions'
}

{ #category : #accessing }
PPTEmptyASTNode >> messageText [
	^ '#' , self rule name
		,
			' - Nothing to store in the AST, maybe you should add this rule to the list of rules to flatten'
]

{ #category : #accessing }
PPTEmptyASTNode >> rule [
	^ rule
]

{ #category : #accessing }
PPTEmptyASTNode >> rule: anObject [
	rule := anObject
]
