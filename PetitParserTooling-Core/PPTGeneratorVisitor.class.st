Class {
	#name : #PPTGeneratorVisitor,
	#superclass : #Object,
	#instVars : [
		'generationStrategy',
		'ruleReifications'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTGeneratorVisitor class >> newWithStrategy: aPPASTGeneratorStrategy onRule: aRule [
	^ self new
		generationStrategy: aPPASTGeneratorStrategy;
		configureOn: aRule;
		yourself
]

{ #category : #config }
PPTGeneratorVisitor >> configureOn: aRuleMethod [
	self
		ruleReifications:
			(aRuleMethod pragmas
				select: [ :aPragma | aPragma key = 'reify:into:' ]
				thenCollect: [ :aValidPragma | 
					(aValidPragma arguments first reject: [ :el | el = #/ ])
						-> aValidPragma arguments second ]) asDictionary
]

{ #category : #accessing }
PPTGeneratorVisitor >> generationStrategy [
	^ generationStrategy
]

{ #category : #accessing }
PPTGeneratorVisitor >> generationStrategy: anObject [
	generationStrategy := anObject
]

{ #category : #initialization }
PPTGeneratorVisitor >> initialize [ 
	super initialize.
	self ruleReifications: Dictionary new
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleReifications [
	^ ruleReifications
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleReifications: anObject [
	ruleReifications := anObject
]
