<template>
	<view class="page">
		<view class="card">
			<view class="card-title">开屏广告（全屏）</view>
			<view class="form-row">
				<text class="label">广告位Id</text>
				<input class="input" v-model="posId" placeholder="请输入开屏广告位 Id" />
			</view>
			<view class="btn-row">
				<button class="btn" type="primary" @click="loadAd">加载并展示</button>
				<button class="btn" @click="destroy">销毁广告</button>
			</view>
			<text class="status" :class="statusClass">{{ statusText }}</text>
		</view>

		<view class="card log-card">
			<view class="card-title">事件回调</view>
			<scroll-view scroll-y class="log-list">
				<view v-if="logs.length === 0" class="log-empty">暂无回调</view>
				<view v-for="(log, i) in logs" :key="i" class="log-line">{{ log }}</view>
			</scroll-view>
		</view>
	</view>
</template>

<script>
// #ifdef APP-PLUS
import * as xiluAd from '@/uni_modules/xiluAdSdk';
// #endif

export default {
	data() {
		return {
			posId: '',
			statusText: '未加载',
			statusClass: 'status-wait',
			logs: []
		};
	},
	onLoad(query) {
		this.posId = decodeURIComponent(query.posId || '');
		uni.setNavigationBarTitle({ title: decodeURIComponent(query.title || '开屏广告') });
	},
	onUnload() {
		// #ifdef APP-PLUS
		xiluAd.destroyAd('splash');
		// #endif
	},
	methods: {
		log(msg) {
			const time = new Date().toLocaleTimeString();
			this.logs.unshift(`[${time}] ${msg}`);
		},
		setStatus(text, cls) {
			this.statusText = text;
			this.statusClass = cls;
		},
		buildEvents() {
			return {
				onReceive: () => {
					this.log('广告加载成功');
					// 加载成功后再主动调用 showAd 展示
					this.showAd();
				},
				onFail: (message) => {
					this.setStatus('加载失败', 'status-err');
					this.log(`广告加载失败：${message}`);
				},
				onExpose: () => this.log('广告曝光'),
				onClick: () => this.log('广告被点击'),
				onSkip: () => this.log('广告被跳过'),
				onClose: () => {
					this.setStatus('广告已关闭', 'status-wait');
					this.log('广告关闭');
				},
				onTick: (remaining) => this.log(`倒计时：${remaining}s`)
			};
		},
		loadAd() {
			// #ifdef APP-PLUS
			if (uni.getSystemInfoSync().platform !== 'ios') {
				uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
				return;
			}
			if (typeof xiluAd === 'undefined' || !xiluAd.loadSplashAd) {
				uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
				return;
			}
			if (!this.posId) {
				uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
				return;
			}
			this.logs = [];
			this.setStatus('正在加载...', 'status-wait');
			xiluAd.loadSplashAd({ posId: this.posId, events: this.buildEvents() });
			// #endif
			// #ifndef APP-PLUS
			uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
			// #endif
		},
		showAd() {
			// #ifdef APP-PLUS
			if (typeof xiluAd === 'undefined' || !xiluAd.showSplashAd) {
				this.setStatus('SDK 未导出 showSplashAd', 'status-err');
				this.log('当前 SDK 未导出 showSplashAd，无法手动展示');
				return;
			}
			xiluAd.showSplashAd();
			this.setStatus('已展示', 'status-ok');
			this.log('广告全屏展示');
			// #endif
		},
		destroy() {
			// #ifdef APP-PLUS
			xiluAd.destroyAd('splash');
			this.setStatus('已销毁', 'status-wait');
			this.log('广告实例已销毁');
			// #endif
		}
	}
};
</script>


<style>
.page {
	min-height: 100vh;
	background-color: #f2f3f7;
	padding: 24rpx;
	box-sizing: border-box;
}

.card {
	background-color: #ffffff;
	border-radius: 20rpx;
	padding: 28rpx;
	margin-bottom: 24rpx;
}

.card-title {
	font-size: 30rpx;
	font-weight: 600;
	color: #1f2329;
	margin-bottom: 20rpx;
}

.form-row {
	display: flex;
	align-items: center;
}

.label {
	font-size: 26rpx;
	color: #646a73;
	width: 130rpx;
}

.input {
	flex: 1;
	height: 68rpx;
	border: 1rpx solid #e4e6eb;
	border-radius: 12rpx;
	padding: 0 20rpx;
	font-size: 26rpx;
	background-color: #fafbfc;
}

.btn-row {
	display: flex;
	margin-top: 24rpx;
}

.btn {
	flex: 1;
	margin: 0 10rpx;
	font-size: 26rpx;
}

.status {
	display: block;
	margin-top: 20rpx;
	font-size: 26rpx;
}

.status-ok {
	color: #10ac84;
}

.status-wait {
	color: #ff9f43;
}

.status-err {
	color: #ee5253;
}

.log-card {
	height: 520rpx;
}

.log-list {
	height: 440rpx;
}

.log-empty {
	font-size: 24rpx;
	color: #b0b4bd;
	text-align: center;
	padding-top: 60rpx;
}

.log-line {
	font-size: 24rpx;
	color: #4a4f58;
	line-height: 44rpx;
	border-bottom: 1rpx solid #f5f6f8;
}
</style>
