---
{"dg-publish":true,"permalink":"/developer/linux/update-zsh-power-10k-theme/","dgPassFrontmatter":true}
---

## Error (shortened)
```shell
[ERROR]: gitstatus failed to initialize.


  Zsh log (/tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.xtrace.log):

...

 System information:

    zsh:      5.9
    uname -a: Linux icicle 6.1.0-35-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.137-1 (2025-05-07) x86_64 GNU/Linux

  If you need help, open an issue and attach this whole error message to it:

    https://github.com/romkatv/gitstatus/issues/new
```

## Fix
```bash
cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git pull
```

Restart your shell session: Simply exit and SSH back in, or run `exec zsh`
## Full Error Log
```shell
[ERROR]: gitstatus failed to initialize.


  Zsh log (/tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.xtrace.log):

    +(anon):7> setopt monitor
    +(anon):9> ((  ! _GITSTATUS_STATE_POWERLEVEL9K  ))
    +(anon):10> [[ -r /proc/version && 'Linux version 6.1.0-35-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 6.1.137-1 (2025-05-07)' == *Microsoft* ]]
    +(anon):13> print -rn
    +(anon):14> zsystem flock -f lock_fd /tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.lock
    +(anon):15> [[ 17 == <1-> ]]
    +(anon):18> typeset -gi '_GITSTATUS_LOCK_FD_POWERLEVEL9K=lock_fd'
    +(anon):20> [[ linux-gnu == cygwin* ]]
    +(anon):41> sysopen -r -o cloexec -u resp_fd /proc/self/fd/16
    +(anon):44> typeset -gi 'GITSTATUS_DAEMON_PID_POWERLEVEL9K=93061'
    +(anon):46> [[ 19 == <1-> ]]
    +(anon):47> typeset -gi '_GITSTATUS_RESP_FD_POWERLEVEL9K=resp_fd'
    +(anon):48> typeset -gi '_GITSTATUS_STATE_POWERLEVEL9K=1'
    +(anon):41> _gitstatus_daemon_p9k_
    +(anon):51> ((  ! async  ))
    +_gitstatus_daemon_p9k_:1> local -i pipe_fd
    +(anon):7> setopt monitor
    +(anon):9> ((  ! _GITSTATUS_STATE_POWERLEVEL9K  ))
    +(anon):51> ((  ! async  ))
    +(anon):52> ((  _GITSTATUS_CLIENT_PID_POWERLEVEL9K == sysparams[pid]  ))
    +(anon):54> local pgid
    +(anon):55> ((  0 < 20  ))
    +(anon):56> [[ -t 19 ]]
    +(anon):57> sysread -s 20 -t 10.0000000000 -i 19 'pgid[$#pgid+1]'
    +(anon):55> ((  20 < 20  ))
    +(anon):59> [[ '               93061' == \ #<1-> ]]
    +(anon):60> typeset -gi 'GITSTATUS_DAEMON_PID_POWERLEVEL9K=pgid'
    +(anon):62> sysopen -w -o cloexec -u req_fd -- /tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.fifo
    +(anon):63> [[ 22 == <1-> ]]
    +(anon):64> typeset -gi '_GITSTATUS_REQ_FD_POWERLEVEL9K=req_fd'
    +(anon):66> print -nru 22 -- }hello\C-_\C-^'
    +(anon):67> local expected=}hello\C-_0\C-^' actual
    +(anon):68> ((  1  ))
    +(anon):68> [[ ! -t 1 && ! -t 0 ]]
    +(anon):69> local -F deadline='EPOCHREALTIME + 4'
    +(anon):73> true
    +(anon):74> [[ -t 19 ]]
    +(anon):75> sysread -s 1 -t 10.0000000000 -i 19 actual
    +(anon):75> return

  Daemon log (/tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.daemon.log):

    +_gitstatus_daemon_p9k_:3> local pgid=93061
    +_gitstatus_daemon_p9k_:4> [[ 93061 == <1-> ]]
    +_gitstatus_daemon_p9k_:5> cd -q /
    +_gitstatus_daemon_p9k_:90> ((  lock_fd == -1  ))
    +_gitstatus_daemon_p9k_:9> trap '' PIPE
    +_gitstatus_daemon_p9k_:11> local uname_sm
    +_gitstatus_daemon_p9k_:12> uname_sm=+_gitstatus_daemon_p9k_:93> zsystem flock -- /tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.lock
    +_gitstatus_daemon_p9k_:12> uname -sm
    +_gitstatus_daemon_p9k_:12> uname_sm='linux x86_64'
    +_gitstatus_daemon_p9k_:13> [[ 'linux x86_64' == [^\ ]##\ [^\ ]## ]]
    +_gitstatus_daemon_p9k_:14> local uname_s=linux
    +_gitstatus_daemon_p9k_:15> local uname_m=x86_64
    +_gitstatus_daemon_p9k_:17> [[ '' == <1-> ]]
    +_gitstatus_daemon_p9k_:20> local cpus
    +_gitstatus_daemon_p9k_:21> ((  ! 0  ))
    +_gitstatus_daemon_p9k_:23> ((  ! 1  ))
    +_gitstatus_daemon_p9k_:23> cpus=+_gitstatus_daemon_p9k_:23> getconf _NPROCESSORS_ONLN
    +_gitstatus_daemon_p9k_:23> cpus=8
    +_gitstatus_daemon_p9k_:27> args+=( -t 16 )
    +_gitstatus_daemon_p9k_:30> mkfifo -- /tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.fifo
    +_gitstatus_daemon_p9k_:31> print -rnu 17 -- '               93061'
    +_gitstatus_daemon_p9k_:33> zf_rm -- /tmp/gitstatus.POWERLEVEL9K.1000.92602.1754410004.1.fifo
    +_gitstatus_daemon_p9k_:35> local _gitstatus_zsh_daemon _gitstatus_zsh_version _gitstatus_zsh_downloaded
    +_gitstatus_daemon_p9k_:43> local gitstatus_plugin_dir_var=_gitstatus_plugin_dir_p9k_
    +_gitstatus_daemon_p9k_:44> local gitstatus_plugin_dir=/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus
    +_gitstatus_daemon_p9k_:45> set -- -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_daemon_p9k_:47> [[ 1 == (|-|+)<1-> ]]
    +_gitstatus_daemon_p9k_:48> source /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install
    +/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install:472> [ -z '' ']'
    +/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install:473> _gitstatus_install_main /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:1> [ -n 5.9 ']'
    +_gitstatus_install_main:2> emulate -L sh -o no_unset
    +_gitstatus_install_main:7> local argv1=/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus
    +_gitstatus_install_main:8> shift
    +_gitstatus_install_main:10> local no_check='' no_install='' uname_s='' uname_m='' gitstatus_dir='' dl_status='' e=''
    +_gitstatus_install_main:11> local opt='' OPTARG='' OPTIND=1
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:14> case d (h)
    +_gitstatus_install_main:14> case d (n)
    +_gitstatus_install_main:14> case d (f)
    +_gitstatus_install_main:14> case d (d)
    +_gitstatus_install_main:55> [ -n '' ']'
    +_gitstatus_install_main:59> [ -z /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus ']'
    +_gitstatus_install_main:63> gitstatus_dir=/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:14> case s (h)
    +_gitstatus_install_main:14> case s (n)
    +_gitstatus_install_main:14> case s (f)
    +_gitstatus_install_main:14> case s (d)
    +_gitstatus_install_main:14> case s (p)
    +_gitstatus_install_main:14> case s (e)
    +_gitstatus_install_main:14> case s (m)
    +_gitstatus_install_main:14> case s (s)
    +_gitstatus_install_main:99> [ -n '' ']'
    +_gitstatus_install_main:103> [ -z linux ']'
    +_gitstatus_install_main:107> uname_s=linux
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:14> case m (h)
    +_gitstatus_install_main:14> case m (n)
    +_gitstatus_install_main:14> case m (f)
    +_gitstatus_install_main:14> case m (d)
    +_gitstatus_install_main:14> case m (p)
    +_gitstatus_install_main:14> case m (e)
    +_gitstatus_install_main:14> case m (m)
    +_gitstatus_install_main:88> [ -n '' ']'
    +_gitstatus_install_main:92> [ -z x86_64 ']'
    +_gitstatus_install_main:96> uname_m=x86_64
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:14> case p (h)
    +_gitstatus_install_main:14> case p (n)
    +_gitstatus_install_main:14> case p (f)
    +_gitstatus_install_main:14> case p (d)
    +_gitstatus_install_main:14> case p (p)
    +_gitstatus_install_main:66> [ -n '' ']'
    +_gitstatus_install_main:70> [ -z 'printf '\''\001'\'' >&17' ']'
    +_gitstatus_install_main:74> dl_status='printf '\''\001'\'' >&17'
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:14> case e (h)
    +_gitstatus_install_main:14> case e (n)
    +_gitstatus_install_main:14> case e (f)
    +_gitstatus_install_main:14> case e (d)
    +_gitstatus_install_main:14> case e (p)
    +_gitstatus_install_main:14> case e (e)
    +_gitstatus_install_main:77> [ -n '' ']'
    +_gitstatus_install_main:81> [ -z 17 ']'
    +_gitstatus_install_main:85> e=17
    +_gitstatus_install_main:13> getopts :s:m:d:p:e:fnh opt -d /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus -s linux -m x86_64 -p 'printf '\''\001'\'' >&17' -e 17 -- _gitstatus_set_daemon_p9k_
    +_gitstatus_install_main:115> shift 11
    +_gitstatus_install_main:117> : 17
    +_gitstatus_install_main:118> : /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus
    +_gitstatus_install_main:120> [ -n '' -a -n '' ']'
    +_gitstatus_install_main:125> [ -z linux ']'
    +_gitstatus_install_main:129> [ -z x86_64 ']'
    +_gitstatus_install_main:134> local daemon=''
    +_gitstatus_install_main:135> local cache_dir=/home/icicle/.cache/gitstatus
    +_gitstatus_install_main:137> [ -z '' ']'
    +_gitstatus_install_main:138> [ -n '' ']'
    +_gitstatus_install_main:142> [ -z '' -a -e /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/usrbin/gitstatusd ']'
    +_gitstatus_install_main:145> [ -n '' ']'
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line=''
    +_gitstatus_install_main:163> [ -n '' ']'
    +_gitstatus_install_main:163> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="cygwin_nt-10.0"; uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="5a8a809dcebdb6aa9b47d37e086c0485424a9d9c136770eec3c26cedf5bb75e3";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="cygwin_nt-10.0"; uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="5a8a809dcebdb6aa9b47d37e086c0485424a9d9c136770eec3c26cedf5bb75e3";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="cygwin_nt-10.0"; uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="5a8a809dcebdb6aa9b47d37e086c0485424a9d9c136770eec3c26cedf5bb75e3";'
    +_gitstatus_install_main:166> uname_s_glob=cygwin_nt-10.0
    +_gitstatus_install_main:166> uname_m_glob=i686
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=5a8a809dcebdb6aa9b47d37e086c0485424a9d9c136770eec3c26cedf5bb75e3
    +_gitstatus_install_main:168> [ -z cygwin_nt-10.0 -o -z i686 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 5a8a809dcebdb6aa9b47d37e086c0485424a9d9c136770eec3c26cedf5bb75e3 ']'
    +_gitstatus_install_main:177> case linux (cygwin_nt-10.0)
    +_gitstatus_install_main:177> case linux (*)
    +_gitstatus_install_main:179> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="cygwin_nt-10.0"; uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="c84cade0d6b86e04c27a6055f45851f6b46d6b88ba58772f7ca8ef4d295c800f";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="cygwin_nt-10.0"; uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="c84cade0d6b86e04c27a6055f45851f6b46d6b88ba58772f7ca8ef4d295c800f";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="cygwin_nt-10.0"; uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="c84cade0d6b86e04c27a6055f45851f6b46d6b88ba58772f7ca8ef4d295c800f";'
    +_gitstatus_install_main:166> uname_s_glob=cygwin_nt-10.0
    +_gitstatus_install_main:166> uname_m_glob=x86_64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.1
    +_gitstatus_install_main:166> sha256=c84cade0d6b86e04c27a6055f45851f6b46d6b88ba58772f7ca8ef4d295c800f
    +_gitstatus_install_main:168> [ -z cygwin_nt-10.0 -o -z x86_64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.1 -o -z c84cade0d6b86e04c27a6055f45851f6b46d6b88ba58772f7ca8ef4d295c800f ']'
    +_gitstatus_install_main:177> case linux (cygwin_nt-10.0)
    +_gitstatus_install_main:177> case linux (*)
    +_gitstatus_install_main:179> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="darwin";         uname_m_glob="arm64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="eae979e990ca37c56ee39fadd0c3f392cbbd0c6bdfb9a603010be60d9e48910a";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="darwin";         uname_m_glob="arm64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="eae979e990ca37c56ee39fadd0c3f392cbbd0c6bdfb9a603010be60d9e48910a";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="darwin";         uname_m_glob="arm64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="eae979e990ca37c56ee39fadd0c3f392cbbd0c6bdfb9a603010be60d9e48910a";'
    +_gitstatus_install_main:166> uname_s_glob=darwin
    +_gitstatus_install_main:166> uname_m_glob=arm64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=eae979e990ca37c56ee39fadd0c3f392cbbd0c6bdfb9a603010be60d9e48910a
    +_gitstatus_install_main:168> [ -z darwin -o -z arm64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z eae979e990ca37c56ee39fadd0c3f392cbbd0c6bdfb9a603010be60d9e48910a ']'
    +_gitstatus_install_main:177> case linux (darwin)
    +_gitstatus_install_main:177> case linux (*)
    +_gitstatus_install_main:179> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="darwin";         uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9fd3913ec1b6b856ab6e08a99a2343f0e8e809eb6b62ca4b0963163656c668e6";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="darwin";         uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9fd3913ec1b6b856ab6e08a99a2343f0e8e809eb6b62ca4b0963163656c668e6";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="darwin";         uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9fd3913ec1b6b856ab6e08a99a2343f0e8e809eb6b62ca4b0963163656c668e6";'
    +_gitstatus_install_main:166> uname_s_glob=darwin
    +_gitstatus_install_main:166> uname_m_glob=x86_64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=9fd3913ec1b6b856ab6e08a99a2343f0e8e809eb6b62ca4b0963163656c668e6
    +_gitstatus_install_main:168> [ -z darwin -o -z x86_64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 9fd3913ec1b6b856ab6e08a99a2343f0e8e809eb6b62ca4b0963163656c668e6 ']'
    +_gitstatus_install_main:177> case linux (darwin)
    +_gitstatus_install_main:177> case linux (*)
    +_gitstatus_install_main:179> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="freebsd";        uname_m_glob="amd64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="8e57ad642251e5acfa430aed82cd4ffe103db0bfadae4a15ccaf462c455d0442";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="freebsd";        uname_m_glob="amd64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="8e57ad642251e5acfa430aed82cd4ffe103db0bfadae4a15ccaf462c455d0442";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="freebsd";        uname_m_glob="amd64";   file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="8e57ad642251e5acfa430aed82cd4ffe103db0bfadae4a15ccaf462c455d0442";'
    +_gitstatus_install_main:166> uname_s_glob=freebsd
    +_gitstatus_install_main:166> uname_m_glob=amd64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=8e57ad642251e5acfa430aed82cd4ffe103db0bfadae4a15ccaf462c455d0442
    +_gitstatus_install_main:168> [ -z freebsd -o -z amd64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 8e57ad642251e5acfa430aed82cd4ffe103db0bfadae4a15ccaf462c455d0442 ']'
    +_gitstatus_install_main:177> case linux (freebsd)
    +_gitstatus_install_main:177> case linux (*)
    +_gitstatus_install_main:179> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="aarch64"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="aarch64"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="aarch64"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=aarch64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225
    +_gitstatus_install_main:168> [ -z linux -o -z aarch64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225 ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (aarch64)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="armv6l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="4bf5a0d0a082f544a48536ad3675930d5d2cc6a8cf906710045e0788f51192b3";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="armv6l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="4bf5a0d0a082f544a48536ad3675930d5d2cc6a8cf906710045e0788f51192b3";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="armv6l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="4bf5a0d0a082f544a48536ad3675930d5d2cc6a8cf906710045e0788f51192b3";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=armv6l
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.1
    +_gitstatus_install_main:166> sha256=4bf5a0d0a082f544a48536ad3675930d5d2cc6a8cf906710045e0788f51192b3
    +_gitstatus_install_main:168> [ -z linux -o -z armv6l -o -z gitstatusd-linux-x86_64 -o -z v1.5.1 -o -z 4bf5a0d0a082f544a48536ad3675930d5d2cc6a8cf906710045e0788f51192b3 ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (armv6l)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="armv7l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="2b9deb29f86c8209114b71b94fc2e1ed936a1658808a1bee46f4a82fd6a1f8cc";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="armv7l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="2b9deb29f86c8209114b71b94fc2e1ed936a1658808a1bee46f4a82fd6a1f8cc";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="armv7l";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.1"; sha256="2b9deb29f86c8209114b71b94fc2e1ed936a1658808a1bee46f4a82fd6a1f8cc";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=armv7l
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.1
    +_gitstatus_install_main:166> sha256=2b9deb29f86c8209114b71b94fc2e1ed936a1658808a1bee46f4a82fd6a1f8cc
    +_gitstatus_install_main:168> [ -z linux -o -z armv7l -o -z gitstatusd-linux-x86_64 -o -z v1.5.1 -o -z 2b9deb29f86c8209114b71b94fc2e1ed936a1658808a1bee46f4a82fd6a1f8cc ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (armv7l)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="armv8l";  file="gitstatusd-${uname_s}-aarch64";        version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="armv8l";  file="gitstatusd-${uname_s}-aarch64";        version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="armv8l";  file="gitstatusd-${uname_s}-aarch64";        version="v1.5.4"; sha256="32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=armv8l
    +_gitstatus_install_main:166> file=gitstatusd-linux-aarch64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225
    +_gitstatus_install_main:168> [ -z linux -o -z armv8l -o -z gitstatusd-linux-aarch64 -o -z v1.5.4 -o -z 32b57eb28bf6d80b280e4020a0045184f8ca897b20b570c12948aa6838673225 ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (armv8l)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="56d55e2e9a202d3072fa612d8fa1faa61243ffc86418a7fa64c2c9d9a82e0f64";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="56d55e2e9a202d3072fa612d8fa1faa61243ffc86418a7fa64c2c9d9a82e0f64";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="i686";    file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="56d55e2e9a202d3072fa612d8fa1faa61243ffc86418a7fa64c2c9d9a82e0f64";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=i686
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=56d55e2e9a202d3072fa612d8fa1faa61243ffc86418a7fa64c2c9d9a82e0f64
    +_gitstatus_install_main:168> [ -z linux -o -z i686 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 56d55e2e9a202d3072fa612d8fa1faa61243ffc86418a7fa64c2c9d9a82e0f64 ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (i686)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="ppc64le"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="1afd072c8c26ef6ec2d9ac11cef96c84cd6f10e859665a6ffcfb6112c758547e";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="ppc64le"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="1afd072c8c26ef6ec2d9ac11cef96c84cd6f10e859665a6ffcfb6112c758547e";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="ppc64le"; file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="1afd072c8c26ef6ec2d9ac11cef96c84cd6f10e859665a6ffcfb6112c758547e";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=ppc64le
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=1afd072c8c26ef6ec2d9ac11cef96c84cd6f10e859665a6ffcfb6112c758547e
    +_gitstatus_install_main:168> [ -z linux -o -z ppc64le -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 1afd072c8c26ef6ec2d9ac11cef96c84cd6f10e859665a6ffcfb6112c758547e ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (ppc64le)
    +_gitstatus_install_main:181> case x86_64 (*)
    +_gitstatus_install_main:183> continue
    +_gitstatus_install_main:161> IFS='' +_gitstatus_install_main:161> read -r line
    +_gitstatus_install_main:162> line='uname_s_glob="linux";          uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9633816e7832109e530c9e2532b11a1edae08136d63aa7e40246c0339b7db304";'
    +_gitstatus_install_main:163> [ -n 'uname_s_glob="linux";          uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9633816e7832109e530c9e2532b11a1edae08136d63aa7e40246c0339b7db304";' ']'
    +_gitstatus_install_main:165> local uname_s_glob='' uname_m_glob='' file='' version='' sha256=''
    +_gitstatus_install_main:166> eval 'uname_s_glob="linux";          uname_m_glob="x86_64";  file="gitstatusd-${uname_s}-${uname_m}";     version="v1.5.4"; sha256="9633816e7832109e530c9e2532b11a1edae08136d63aa7e40246c0339b7db304";'
    +_gitstatus_install_main:166> uname_s_glob=linux
    +_gitstatus_install_main:166> uname_m_glob=x86_64
    +_gitstatus_install_main:166> file=gitstatusd-linux-x86_64
    +_gitstatus_install_main:166> version=v1.5.4
    +_gitstatus_install_main:166> sha256=9633816e7832109e530c9e2532b11a1edae08136d63aa7e40246c0339b7db304
    +_gitstatus_install_main:168> [ -z linux -o -z x86_64 -o -z gitstatusd-linux-x86_64 -o -z v1.5.4 -o -z 9633816e7832109e530c9e2532b11a1edae08136d63aa7e40246c0339b7db304 ']'
    +_gitstatus_install_main:177> case linux (linux)
    +_gitstatus_install_main:181> case x86_64 (x86_64)
    +_gitstatus_install_main:188> [ -z '' ']'
    +_gitstatus_install_main:190> local daemon=/home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/usrbin/gitstatusd-linux-x86_64
    +_gitstatus_install_main:191> [ ! -e /home/icicle/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/usrbin/gitstatusd-linux-x86_64 ']'
    +_gitstatus_install_main:192> daemon=/home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64
    +_gitstatus_install_main:193> [ -e /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 ']'
    +_gitstatus_install_main:195> [ -n /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 ']'
    +_gitstatus_install_main:196> _gitstatus_install_daemon_found 0 _gitstatus_set_daemon_p9k_
    +_gitstatus_install_daemon_found:1> local installed=0
    +_gitstatus_install_daemon_found:2> shift
    +_gitstatus_install_daemon_found:3> [ 1 '=' 0 ']'
    +_gitstatus_install_daemon_found:3> _gitstatus_set_daemon_p9k_ /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 v1.5.4 0
    +_gitstatus_set_daemon_p9k_:1> _gitstatus_zsh_daemon=/home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64
    +_gitstatus_set_daemon_p9k_:2> _gitstatus_zsh_version=v1.5.4
    +_gitstatus_set_daemon_p9k_:3> _gitstatus_zsh_downloaded=0
    +_gitstatus_install_main:197> return
    +_gitstatus_daemon_p9k_:49> [[ -n /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 ]]
    +_gitstatus_daemon_p9k_:50> [[ -n v1.5.4 ]]
    +_gitstatus_daemon_p9k_:51> [[ 0 == [01] ]]
    +_gitstatus_daemon_p9k_:53> ((  UID == EUID  ))
    +_gitstatus_daemon_p9k_:54> local home=/home/icicle
    +_gitstatus_daemon_p9k_:62> [[ -x /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 ]]
    +_gitstatus_daemon_p9k_:63> HOME=/home/icicle /home/icicle/.cache/gitstatus/gitstatusd-linux-x86_64 -G v1.5.4 -s -1 -u -1 -d -1 -c -1 -m -1 -v DEBUG -t 16

  System information:

    zsh:      5.9
    uname -a: Linux icicle 6.1.0-35-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.137-1 (2025-05-07) x86_64 GNU/Linux

  If you need help, open an issue and attach this whole error message to it:

    https://github.com/romkatv/gitstatus/issues/new
```