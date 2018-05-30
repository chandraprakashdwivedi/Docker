pipeline {
  agent {
   dockerfile true
  }
  stages {
    stage('Example') {
      steps {
      	echo 'Hellow world'
	sh 'echo my_custom_env_variable = $my_custom_env_variable'
      }
    }
  }
}

