# MojangApi

A quick ruby gem for utilizing the Mojang Profile/UUID api and managing multiple versions of whitelists.

## Usage

```ruby
MojangApi.get_profile_from_name('downslope7')

MojangApi.get_profile_from_uuid('8cf6171562164903bb03e9653c4eba15')

MojangApi.get_profiles_from_name_list(['notch','Dinnerbone', 'Djinnibone', 'downslope7'])
```
