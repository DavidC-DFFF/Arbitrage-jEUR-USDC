# Arbitrage-jEUR-USDC

Test d'arbitrage manuel depuis kyverswap vers jarvis
Si prix jEUR > sur kyber que sur Jarvis :
- flashloan USDC sur AAVE
- mint jEUR sur Jarvis
- vend jEUR sur kyber
- payback USDC sur AAVE

Si prix jEUR < sur Kyber que sur Jarvis :
- flashloan USDC sur AAVE
- achète jEUR sur Kyber
- redeem jEUR sur Jarvis
- payback USDC sur AAVE
