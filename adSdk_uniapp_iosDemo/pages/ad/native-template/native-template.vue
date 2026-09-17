<template>
	<view class="page">
		<view class="card">
			<view class="card-title">信息流模板广告</view>
			<view class="form-row">
				<text class="label">广告位Id</text>
				<input class="input" v-model="posId" placeholder="请输入信息流模板广告位 Id" />
			</view>
			<view class="btn-row">
				<button class="btn" type="primary" @click="loadAd">加载广告</button>
				<!-- <button class="btn" @click="addMock">加测试数据</button> -->
				<button class="btn" @click="destroy">销毁广告</button>
			</view>
			<text class="status" :class="statusClass">{{ statusText }}</text>
		</view>

		<view class="card log-card compact">
			<view class="card-title">事件回调</view>
			<scroll-view scroll-y class="log-list">
				<view v-if="logs.length === 0" class="log-empty">暂无回调</view>
				<view v-for="(log, i) in logs" :key="i" class="log-line">{{ log }}</view>
			</scroll-view>
		</view>

		<!-- 原生信息流广告悬浮层会精准覆盖到本占位区 -->
		<view class="native-placeholder" id="nativePlaceholder">
			<text class="placeholder-text">信息流广告展示区域（原生层可上下滑动）</text>
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
		uni.setNavigationBarTitle({ title: decodeURIComponent(query.title || '信息流模板广告') });
	},
	onUnload() {
		// #ifdef APP-PLUS
		xiluAd.destroyAd('native');
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
					this.log('信息流模板广告加载成功');
					// 加载成功后主动调用 showAd 渲染到原生容器
					this.showAd();
				},
				onFail: (message) => {
					this.setStatus('加载失败', 'status-err');
					this.log(`信息流广告加载失败：${message}`);
				},
				onExpose: () => this.log('广告曝光'),
				onClick: () => this.log('广告被点击'),
				onClose: () => {
					this.setStatus('广告已关闭', 'status-wait');
					this.log('信息流广告关闭');
				}
			};
		},
		loadAd() {
			// #ifdef APP-PLUS
			if (uni.getSystemInfoSync().platform !== 'ios') {
				uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
				return;
			}
			if (typeof xiluAd === 'undefined' || !xiluAd.loadNativeTemplateAd) {
				uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
				return;
			}
			if (!this.posId) {
				uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
				return;
			}
			this.logs = [];
			this.setStatus('正在加载...', 'status-wait');

			const sys = uni.getSystemInfoSync();
			const navOffset = (sys.statusBarHeight || 0) + 44;

			uni.createSelectorQuery()
				.in(this)
				.select('#nativePlaceholder')
				.boundingClientRect((rect) => {
					if (!rect) {
						uni.showToast({ title: '未找到展示区域', icon: 'none' });
						return;
					}
					const top = rect.top + navOffset;
					const height = rect.height;
					const width = rect.width;
					const left = rect.left;
					this.log(`占位区坐标：top=${top} left=${left} ${width}x${height}`);

					xiluAd.loadNativeTemplateAd({
						posId: this.posId,
						count: 3,
						top: top,
						events: this.buildEvents()
					});
				})
				.exec();
			// #endif
			// #ifndef APP-PLUS
			uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
			// #endif
		},
		// onReceive 里调用，真正把卡片渲染到原生容器
		showAd() {
			// #ifdef APP-PLUS
			if (typeof xiluAd === 'undefined' || !xiluAd.showNativeTemplateAd) {
				this.setStatus('SDK 未导出 showNativeTemplateAd', 'status-err');
				this.log('当前 SDK 未导出 showNativeTemplateAd，无法手动渲染');
				return;
			}
			xiluAd.showNativeTemplateAd();
			this.setStatus('加载成功', 'status-ok');
			this.log('信息流模板广告已渲染到容器');
			// #endif
		},
		addMock() {
			// #ifdef APP-PLUS
			if (typeof xiluAd === 'undefined' || !xiluAd.addNativeTestCards) {
				uni.showToast({ title: '当前基座不含广告插件', icon: 'none' });
				return;
			}
			xiluAd.addNativeTestCards(3);
			this.log('已追加 3 张测试卡片，可上下滑动查看');
			// #endif
			// #ifndef APP-PLUS
			uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
			// #endif
		},
		destroy() {
			// #ifdef APP-PLUS
			xiluAd.destroyAd('native');
			this.setStatus('已销毁', 'status-wait');
			this.log('信息流广告已销毁');
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
	margin: 0 8rpx;
	font-size: 24rpx;
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

/* ===== 事件回调卡片改小 ===== */
.log-card.compact {
	height: 200rpx;
}

.log-list {
	height: 120rpx;
}

.log-empty {
	font-size: 24rpx;
	color: #b0b4bd;
	text-align: center;
	padding-top: 20rpx;
}

.log-line {
	font-size: 24rpx;
	color: #4a4f58;
	line-height: 40rpx;
	border-bottom: 1rpx solid #f5f6f8;
}

/* ===== 信息流占位区放大 ===== */
.native-placeholder {
	height: 600rpx;
	border: 2rpx dashed #c8ccd4;
	border-radius: 12rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #fafbfc;
}

.placeholder-text {
	font-size: 22rpx;
	color: #a0a6b0;
}
</style>
