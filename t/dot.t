# sh

t_diag "Tests for dot.sh"

mkdir -p tmp

t::group "Can't load dot.sh without DOTS_ROOT variable" ({
  unset DOTS_ROOT
  . dot.sh
  t_ne $? 0 "fail to source dot.sh"
})

t::group "With DOTS_ROOT set correctly" ({
  DOTS_ROOT=tmp
  echo "foo=bar" > tmp/.env
  t_diag "And when DOTS_ENV is not set"
  unset foo DOTS_ENV

  . dot.sh
  t_eq $? 0 "succeed to source dot.sh"
  t_is "$(route .env)" "tmp/.env" "CMD 'route .env' => 'tmp/.env'"
  require .env
  t_eq $? 0 "CMD 'require .env' succeed"
  t_is "$foo" "bar" "foo = bar"
})

t::group "When \"test\" environment exists under the right DOTS_ROOT" ({
  mkdir -p tmp/envs/test
  DOTS_ROOT=tmp
  echo "foo=bar" > tmp/.env
  unset foo DOTS_ENV

  t::group "When DOTS_ENV=test" ({
    DOTS_ENV=test
    echo "foo=baz" > tmp/envs/test/.env

    . dot.sh
    t_eq $? 0 "succeed to source dot.sh"
    t_is "$(route .env)" "tmp/envs/test/.env" "CMD 'route .env' => 'tmp/envs/test/.env'"
    require .env
    t_eq $? 0 "CMD 'require .env' succeed"
    t_is "$foo" "baz" "foo = baz"
  })

  t::group "When DOTS_ENV is invalid" ({
    echo "foo=baz" > tmp/envs/test/.env
    DOTS_ENV=no-such-env

    . dot.sh
    t_eq $? 0 "succeed to source dot.sh"
    t_is "$(route .env)" "tmp/.env" "CMD 'route .env' => 'tmp/.env'"
    require .env
    t_eq $? 0 "CMD 'require .env' succeed"
    t_is "$foo" "bar" "foo = bar"
  })
})

rm -rf tmp
