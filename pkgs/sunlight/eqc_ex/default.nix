{fetchgit, beamPackages, sunlight } :
with beamPackages;
buildMix rec
{
  name = "eqc_ex";
  version = "1.2.4";
  src = fetchgit {
    url = "https://github.com/Quviq/eqc_ex";
    rev = "fdfa4c3b7d8f37e0b358704a4feeaa8f4ba4820f";
    sha256 = "1ziyp8c17hb98z6yiykm434k68qyh3wal78chj2lhpjlq3wvc7ai";
  };
  beamDeps = [ sunlight.eqc ];
} 
