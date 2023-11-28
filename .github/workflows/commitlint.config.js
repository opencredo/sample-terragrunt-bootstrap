module.exports = {

  rules: {

    'type-enum': [2, 'always', ['build', 'ci', 'docs', 'feat', 'fix', 'perf', 'refactor', 'test']],

    'subject-case': [2, 'always', 'lower-case'],
    
    'subject-empty': [2, 'never'],
    
    'subject-full-stop': [2, 'never', '.'],

  },

  prompt: {
    settings: { 
      enable: true,
      maxSubjectLength: 80,
    }    
  },
  
  messages: {
    'subject-empty': 'Subject cannot be empty.',
    'subject-full-stop': 'Subject cannot end with period.',
  }  
  
};
