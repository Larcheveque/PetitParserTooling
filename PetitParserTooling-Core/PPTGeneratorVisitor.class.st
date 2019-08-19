"
I am an abstract visitor for generator based on a PPTASTGeneratorStrategy
"
Class {
	#name : #PPTGeneratorVisitor,
	#superclass : #Object,
	#instVars : [
		'generationStrategy',
		'ruleReifications',
		'ruleRenaming',
		'ruleLocalIgnoring',
		'globalReification'
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
PPTGeneratorVisitor >> configureLocalIgnoring: aRuleMethod [
	self
		ruleLocalIgnoring:
			(aRuleMethod pragmas
				select: [ :aPragma | aPragma selector = 'ignore:' ]
				thenCollect: [ :aValidPragma | aValidPragma arguments first value ])
]

{ #category : #config }
PPTGeneratorVisitor >> configureOn: aRuleMethod [
	self configureReifications: aRuleMethod.
	self configureRenaming: aRuleMethod.
	self configureLocalIgnoring: aRuleMethod
]

{ #category : #config }
PPTGeneratorVisitor >> configureReifications: aRuleMethod [
	self
		ruleReifications:
			(aRuleMethod pragmas
				select: [ :aPragma | aPragma selector = 'reify:into:' ]
				thenCollect: [ :aValidPragma | 
					(aValidPragma arguments first value reject: [ :el | el = #/ ])
						-> aValidPragma arguments second value ]) asDictionary.
	aRuleMethod pragmas
		select: [ :aPragma | aPragma selector = 'reifyAllInto:' ]
		thenDo:
			[ :aValidPragma | self globalReification: aValidPragma arguments first value]
]

{ #category : #config }
PPTGeneratorVisitor >> configureRenaming: aRuleMethod [
	self
		ruleRenaming:
			(aRuleMethod pragmas
				select: [ :aPragma | aPragma selector = 'rename:into:' ]
				thenCollect: [ :aValidPragma | 
					aValidPragma arguments first value
						->
							(aValidPragma arguments second value isString
								ifFalse: [ Stack withAll: aValidPragma arguments second value ]
								ifTrue: [ Stack with: aValidPragma arguments second value ]) ])
				asDictionary
]

{ #category : #accessing }
PPTGeneratorVisitor >> generationStrategy [
	^ generationStrategy
]

{ #category : #accessing }
PPTGeneratorVisitor >> generationStrategy: anObject [
	generationStrategy := anObject
]

{ #category : #accessing }
PPTGeneratorVisitor >> globalReification [
	^ globalReification
]

{ #category : #accessing }
PPTGeneratorVisitor >> globalReification: anObject [
	globalReification := anObject
]

{ #category : #initialization }
PPTGeneratorVisitor >> initialize [ 
	super initialize.
	self ruleReifications: Dictionary new
]

{ #category : #testing }
PPTGeneratorVisitor >> isASeparatedBy: aPP2ActionNode [
	"this test reflect the structure of the parser tree created when you do a #separatedBy: in PetitParser2"

	^ [ aPP2ActionNode child children second child children second
		= aPP2ActionNode child children first ]
		on: MessageNotUnderstood
		do: [ false ]
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleLocalIgnoring [
	^ ruleLocalIgnoring
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleLocalIgnoring: anObject [
	ruleLocalIgnoring := anObject
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleReifications [
	^ ruleReifications
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleReifications: anObject [
	ruleReifications := anObject
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleRenaming [
	^ ruleRenaming
]

{ #category : #accessing }
PPTGeneratorVisitor >> ruleRenaming: anObject [
	ruleRenaming := anObject
]

{ #category : #config }
PPTGeneratorVisitor >> shouldBeLocalyIgnored: aRuleName [
	^ self ruleLocalIgnoring includes: aRuleName
]
